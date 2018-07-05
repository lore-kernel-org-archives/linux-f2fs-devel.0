From: "Xu, Wen" <wen.xu@gatech.edu>
Subject: Bug report: some new bugs found by fuzzing
Date: Thu, 5 Jul 2018 19:19:31 +0000
Message-ID: <B655752F-CBBA-4D7D-B504-E1E21378429A@gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wen.xu@gatech.edu>) id 1fb9n3-0004yr-Mc
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 05 Jul 2018 19:19:41 +0000
Received: from mail-eopbgr700126.outbound.protection.outlook.com
 ([40.107.70.126] helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-SHA384:256) (Exim 4.90_1)
 id 1fb9n0-00AhVI-1j
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 05 Jul 2018 19:19:41 +0000
Content-Language: en-US
Content-ID: <15523D4020BA7D498A1312864F79D886@namprd07.prod.outlook.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

RGVhciBGMkZTIGRldmVsb3BlcnMsDQoNCkJ5IGZ1enppbmcsIEkgZmluZCBzb21lIG5ldyBpc3N1
ZXMgaW4gTGludXggZjJmcyBrZXJuZWwgbW9kdWxlLiBIZXJlIGFyZSB0aGUgbGlua3Mgb24gQnVn
emlsbGEsDQoNCjIwMDQxOQlOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgaW4gX19yZW1vdmVfZGly
dHlfc2VnbWVudCgpIHdoZW4gbW91bnRpbmcgYW4gZjJmcyBpbWFnZQ0KaHR0cHM6Ly9idWd6aWxs
YS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMDA0MTkNCg0KMjAwNDIxCUJ1ZmZlciBvdmVy
cnVuIGluIGYyZnNfdHJ1bmNhdGVfaW5saW5lX2lub2RlKCkgd2hlbiB1bW91bnRpbmcgYW4gZjJm
cyBpbWFnZQ0KaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMDA0
MjENCg0KMjAwNDIzCU91dC1vZi1ib3VuZCBhY2Nlc3MgaW4gZjJmc19nZXRfZG5vZGVfb2ZfZGF0
YSgpIHdoZW4gb3BlcmF0aW5nIGZpbGUgb24gYW4gZjJmcyBpbWFnZQ0KaHR0cHM6Ly9idWd6aWxs
YS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMDA0MjMNCg0KMjAwNDI1CUludmFsaWQgbWVt
b3J5IGFjY2VzcyBpbiBmMmZzX2ZpbmRfdGFyZ2V0X2RlbnRyeSgpIHdoZW4gb3BlcmF0aW5nIGZp
bGVzIG9uIGFuIGYyZnMgaW1hZ2UNCmh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1
Zy5jZ2k/aWQ9MjAwNDI1DQoNClJlZ2FyZGluZyBteSB0ZXN0aW5nLCB0aGV5IGNhbiBhbGwgYmUg
cmVwcm9kdWNlZCB3LyBDaGFv4oCZcyBmMmZzLWRldiBicmFuY2guIFRoYW5rcyENCg0KLVdlbgot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KQ2hlY2sgb3V0IHRoZSB2aWJyYW50IHRlY2ggY29tbXVuaXR5
IG9uIG9uZSBvZiB0aGUgd29ybGQncyBtb3N0CmVuZ2FnaW5nIHRlY2ggc2l0ZXMsIFNsYXNoZG90
Lm9yZyEgaHR0cDovL3NkbS5saW5rL3NsYXNoZG90Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4
LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9y
Z2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
