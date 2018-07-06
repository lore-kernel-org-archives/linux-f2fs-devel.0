From: "Xu, Wen" <wen.xu@gatech.edu>
Subject: Re: Bug report: some new bugs found by fuzzing
Date: Fri, 6 Jul 2018 01:30:09 +0000
Message-ID: <0C7436B3-FE05-4999-A163-89F9851ADC00@gatech.edu>
References: <B655752F-CBBA-4D7D-B504-E1E21378429A@gatech.edu>
 <7f5282db-2bb6-b808-679b-620957185945@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wen.xu@gatech.edu>) id 1fbFZj-0005Po-7b
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Jul 2018 01:30:19 +0000
Received: from mail-eopbgr700114.outbound.protection.outlook.com
 ([40.107.70.114] helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-SHA384:256) (Exim 4.90_1)
 id 1fbFZh-000RiX-7D
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Jul 2018 01:30:19 +0000
In-Reply-To: <7f5282db-2bb6-b808-679b-620957185945@huawei.com>
Content-Language: en-US
Content-ID: <6C54C4D34270624FAFB2BD8F66B09824@namprd07.prod.outlook.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

VGhhbmtzIHZlcnkgbXVjaCEgSSB3b3VsZCBsaWtlIHRvIHByb3ZpZGUgYW55IGZ1cnRoZXIgaGVs
cCBvciB0ZXN0aW5nLg0KDQotV2VuDQoNCj4gT24gSnVsIDUsIDIwMTgsIGF0IDk6MTMgUE0sIENo
YW8gWXUgPHl1Y2hhbzBAaHVhd2VpLmNvbT4gd3JvdGU6DQo+IA0KPiBIaSBXZW4sDQo+IA0KPiBP
biAyMDE4LzcvNiAzOjE5LCBYdSwgV2VuIHdyb3RlOg0KPj4gRGVhciBGMkZTIGRldmVsb3BlcnMs
DQo+PiANCj4+IEJ5IGZ1enppbmcsIEkgZmluZCBzb21lIG5ldyBpc3N1ZXMgaW4gTGludXggZjJm
cyBrZXJuZWwgbW9kdWxlLiBIZXJlIGFyZSB0aGUgbGlua3Mgb24gQnVnemlsbGEsDQo+PiANCj4+
IDIwMDQxOQlOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgaW4gX19yZW1vdmVfZGlydHlfc2VnbWVu
dCgpIHdoZW4gbW91bnRpbmcgYW4gZjJmcyBpbWFnZQ0KPj4gaHR0cHM6Ly9idWd6aWxsYS5rZXJu
ZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMDA0MTkNCj4+IA0KPj4gMjAwNDIxCUJ1ZmZlciBvdmVy
cnVuIGluIGYyZnNfdHJ1bmNhdGVfaW5saW5lX2lub2RlKCkgd2hlbiB1bW91bnRpbmcgYW4gZjJm
cyBpbWFnZQ0KPj4gaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0y
MDA0MjENCj4+IA0KPj4gMjAwNDIzCU91dC1vZi1ib3VuZCBhY2Nlc3MgaW4gZjJmc19nZXRfZG5v
ZGVfb2ZfZGF0YSgpIHdoZW4gb3BlcmF0aW5nIGZpbGUgb24gYW4gZjJmcyBpbWFnZQ0KPj4gaHR0
cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMDA0MjMNCj4+IA0KPj4g
MjAwNDI1CUludmFsaWQgbWVtb3J5IGFjY2VzcyBpbiBmMmZzX2ZpbmRfdGFyZ2V0X2RlbnRyeSgp
IHdoZW4gb3BlcmF0aW5nIGZpbGVzIG9uIGFuIGYyZnMgaW1hZ2UNCj4+IGh0dHBzOi8vYnVnemls
bGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjAwNDI1DQo+PiANCj4+IFJlZ2FyZGluZyBt
eSB0ZXN0aW5nLCB0aGV5IGNhbiBhbGwgYmUgcmVwcm9kdWNlZCB3LyBDaGFv4oCZcyBmMmZzLWRl
diBicmFuY2guIFRoYW5rcyENCj4gDQo+IEFscmlnaHQsIEkgd2lsbCBkaWcgaW50byB0aGVzZSBp
c3N1ZXMgaW4gdGhlc2UgZGF5cywgb25jZSBJIGhhdmUgc29sdXRpb24sIHdpbGwNCj4gbGV0IHlv
dSBrbm93Lg0KPiANCj4gVGhhbmtzLA0KPiANCj4+IA0KPj4gLVdlbg0KDQotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KQ2hlY2sgb3V0IHRoZSB2aWJyYW50IHRlY2ggY29tbXVuaXR5IG9uIG9uZSBvZiB0
aGUgd29ybGQncyBtb3N0CmVuZ2FnaW5nIHRlY2ggc2l0ZXMsIFNsYXNoZG90Lm9yZyEgaHR0cDov
L3NkbS5saW5rL3NsYXNoZG90Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxA
bGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3Rz
L2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
