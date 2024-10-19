import 'package:flutter/material.dart';

import 'scores/chadsvasc/chadsvasc_page.dart';
import 'scores/correctedqt/correctedqt_page.dart';
import 'scores/hasbled/hasbled_page.dart';
import 'scores/hcmriskscd/hcmriskscd_page.dart';
import 'scores/hemorrhages/hemorrhages_page.dart';
import 'scores/phhfgroup/phhfgroup_page.dart';
import 'scores/canadiansyncope/canadiansyncope_page.dart';
import 'scores/ventriculartachycardia/ventriculartachycardia_page.dart';

import 'views/mainpages/homepage.dart';
import 'views/mainpages/infopage.dart';
import 'views/mainpages/scorepage_structure.dart';
import 'views/mainpages/searchpage.dart';
import 'views/mainpages/settings_page.dart';

class Routes
{
	static Map<String, Widget Function(BuildContext)> get routes =>
	{
		// SafeArea(top: false) is used for statusBar color if PageView used as it is in HomePage
		'/': (context) => const SafeArea(top: false, child: HomePage()),
		'/settings': (context) => const SafeArea(top: false, child: SettingsPage()),
		'/info': (context) => const SafeArea(top: false, child: InfoPage()),
		'/search': (context) => const SafeArea(top: false, child: SearchPage()),
        '/canadianSyncopeRisk': (context) => const ScorePage(body: CanadianSyncopePage()),
        '/chadsVasc': (context) => const ScorePage(body: ChadsVascPage()),
        '/hasBled': (context) => const ScorePage(body: HasBledPage()),
        '/hcmRiskScd': (context) => const ScorePage(body: HcmRiskScdPage()),
        '/hemorrhages': (context) => const ScorePage(body: HemorrhagesPage()),
        '/correctedQt': (context) => const ScorePage(body: CorrectedQTPage()),
        '/ventricularTachycardia': (context) => const ScorePage(body: VentricularTachycardiaPage()),
        // '/amyloidosis': (context) => const ScorePage(body: AmyloidosisPage()),
        // '/constriction': (context) => const ScorePage(body: ConstrictionPage()),
        // '/diastolicFunction': (context) => const ScorePage(body: DiastolicFunctionPage()),
        // '/haemodynamics': (context) => const ScorePage(body: HaemodynamicsPage()),
        '/phhfGroup': (context) => const ScorePage(body: PhhfGroupPage()),
        // '/pulmonaryHypertensionProbability': (context) => const ScorePage(body: PulmonaryHypertensionProbabilityPage()),
        // '/qualify': (context) => const ScorePage(body: QualifyPage()),
        // '/sts': (context) => const ScorePage(body: StsPage()),
        // '/geneva': (context) => const ScorePage(body: GenevaPage()),
        // '/pesi': (context) => const ScorePage(body: PesiPage()),
        // '/wells': (context) => const ScorePage(body: WellsPage()),
        // '/dukesCriteria': (context) => const ScorePage(body: DukesCriteriaPage()),
        // '/bmi': (context) => const ScorePage(body: BmiPage()),
        // '/bodySurfaceArea': (context) => const ScorePage(body: BodySurfaceAreaPage()),
        // '/clearance': (context) => const ScorePage(body: ClearancePage()),
        // '/unitConversion': (context) => const ScorePage(body: UnitConversionPage()),
        // '/ureaExcretionFraction': (context) => const ScorePage(body: UreaExcretionFractionPage()),
	};
}