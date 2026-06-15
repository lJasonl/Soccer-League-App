import 'package:flutter/material.dart';

import '../coach/coachscreen.dart';
import '../referee/screen.dart';
import '../users/screen.dart';
import '../scholarships/scholarship_screen.dart';

import '../../services/coach_data_service.dart';
import '../../services/referee_data_service.dart';
import '../../services/user_data_service.dart';
import '../../services/scholarship_data_service.dart';
import '../../services/volunteer_data_service.dart';

import 'registration_fee_screen.dart';
import 'season_management_screen.dart';
import 'announcement_management_screen.dart';

class Screen extends StatelessWidget {
  const Screen({super.key});

  static const Color dcsaNavy =
      Color(0xFF0B2A5B);

  @override
  Widget build(BuildContext context) {
    final volunteerHours =
        VolunteerDataService.entries.fold<double>(
      0,
      (sum, entry) =>
          sum + entry.hoursWorked,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Center',
        ),
      ),
      body: ListView(
        padding:
            const EdgeInsets.all(16),
        children: [
          Container(
            padding:
                const EdgeInsets.all(
              20,
            ),
            decoration: BoxDecoration(
              color: dcsaNavy,
              borderRadius:
                  BorderRadius.circular(
                24,
              ),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.admin_panel_settings,
                  color: Colors.white,
                  size: 48,
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'DCSA Admin Center',
                  textAlign:
                      TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  '${UserDataService.users.length} Users Managed',
                  style:
                      const TextStyle(
                    color:
                        Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          Row(
            children: [
              Expanded(
                child: _statCard(
                  'Users',
                  UserDataService
                      .users.length
                      .toString(),
                  Icons.people,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: _statCard(
                  'Coaches',
                  CoachDataService
                      .coaches.length
                      .toString(),
                  Icons.sports_soccer,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 10,
          ),

          Row(
            children: [
              Expanded(
                child: _statCard(
                  'Referees',
                  RefereeDataService
                      .referees.length
                      .toString(),
                  Icons.gavel,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: _statCard(
                  'Volunteer Hrs',
                  volunteerHours
                      .toStringAsFixed(0),
                  Icons.volunteer_activism,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 24,
          ),

          const Text(
            'Administration',
            style: TextStyle(
              fontSize: 22,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          _adminCard(
            context,
            icon:
                Icons.volunteer_activism,
            title:
                'Scholarship Management',
            subtitle:
                '${ScholarshipDataService.activeFamilyCount} Active Families',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const ScholarshipScreen(),
                ),
              );
            },
          ),

          _adminCard(
            context,
            icon:
                Icons.campaign,
            title:
                'Announcements',
            subtitle:
                'Manage league announcements',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const AnnouncementManagementScreen(),
                ),
              );
            },
          ),

          _adminCard(
            context,
            icon:
                Icons.attach_money,
            title:
                'Registration Fees',
            subtitle:
                'Manage registration pricing',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const RegistrationFeeScreen(),
                ),
              );
            },
          ),

          _adminCard(
            context,
            icon:
                Icons.calendar_month,
            title:
                'Season Management',
            subtitle:
                'Manage league seasons',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const SeasonManagementScreen(),
                ),
              );
            },
          ),

          _adminCard(
            context,
            icon:
                Icons.sports_soccer,
            title:
                'Coach Management',
            subtitle:
                '${CoachDataService.coaches.length} Coaches',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const CoachScreen(),
                ),
              );
            },
          ),

          _adminCard(
            context,
            icon:
                Icons.gavel,
            title:
                'Referee Management',
            subtitle:
                '${RefereeDataService.referees.length} Referees',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const RefereeScreen(),
                ),
              );
            },
          ),

          _adminCard(
            context,
            icon:
                Icons.people,
            title:
                'User Roles',
            subtitle:
                '${UserDataService.users.length} Users',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const UserScreen(),
                ),
              );
            },
          ),

          _adminCard(
            context,
            icon:
                Icons.settings,
            title:
                'League Settings',
            subtitle:
                'Configuration & preferences',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _statCard(
    String title,
    String value,
    IconData icon,
  ) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.all(
          12,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: dcsaNavy,
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              value,
              style:
                  const TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            Text(
              title,
              style:
                  const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _adminCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin:
          const EdgeInsets.only(
        bottom: 12,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              dcsaNavy.withValues(
            alpha: .1,
          ),
          child: Icon(
            icon,
            color: dcsaNavy,
          ),
        ),
        title: Text(
          title,
          style:
              const TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
        ),
        trailing: const Icon(
          Icons.chevron_right,
        ),
        onTap: onTap,
      ),
    );
  }
}