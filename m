From: Yuan Zhong <yuan.mark.zhong@samsung.com>
Subject: [f2fs-dev] [PATCH 2/3] f2fs:set the correct place of initializing
 *res_page
Date: Sat, 07 Mar 2015 10:07:43 +0000 (GMT)
Message-ID: <190202356.458601425722862565.JavaMail.weblogic@epmlwas08b>
Reply-To: yuan.mark.zhong@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
MIME-version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

VGhlIGZ1bmN0aW9uICdmaW5kX2luX2lubGluZV9kaXIoKScgY29udGFpbiAncmVzX3BhZ2UnDQph
cyBhbiBhcmd1bWVudC4gU28sIHdlIHNob3VsZCBpbml0aWFpemUgJ3Jlc19wYWdlJyBiZWZvcmUN
CnRoaXMgZnVuY3Rpb24uDQoJDQpTaWduZWQtb2ZmLWJ5OiBZdWFuIFpob25nIDx5dWFuLm1hcmsu
emhvbmdAc2Ftc3VuZy5jb20+CQ0KLS0tDQogZnMvZjJmcy9kaXIuYyB8ICAgIDQgKystLQ0KIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1n
aXQgYS9mcy9mMmZzL2Rpci5jIGIvZnMvZjJmcy9kaXIuYw0KaW5kZXggNTkwYWVlZi4uYTI4OTA5
ZCAxMDA2NDQNCi0tLSBhL2ZzL2YyZnMvZGlyLmMNCisrKyBiL2ZzL2YyZnMvZGlyLmMNCkBAIC0y
MTksMTQgKzIxOSwxNCBAQCBzdHJ1Y3QgZjJmc19kaXJfZW50cnkgKmYyZnNfZmluZF9lbnRyeShz
dHJ1Y3QgaW5vZGUgKmRpciwNCiAJdW5zaWduZWQgaW50IG1heF9kZXB0aDsNCiAJdW5zaWduZWQg
aW50IGxldmVsOw0KIA0KKwkqcmVzX3BhZ2UgPSBOVUxMOw0KKw0KIAlpZiAoZjJmc19oYXNfaW5s
aW5lX2RlbnRyeShkaXIpKQ0KIAkJcmV0dXJuIGZpbmRfaW5faW5saW5lX2RpcihkaXIsIGNoaWxk
LCByZXNfcGFnZSk7DQogDQogCWlmIChucGFnZXMgPT0gMCkNCiAJCXJldHVybiBOVUxMOw0KIA0K
LQkqcmVzX3BhZ2UgPSBOVUxMOw0KLQ0KIAluYW1lX2hhc2ggPSBmMmZzX2RlbnRyeV9oYXNoKGNo
aWxkKTsNCiAJbWF4X2RlcHRoID0gRjJGU19JKGRpciktPmlfY3VycmVudF9kZXB0aDsNCiANCi0t
IA0KMS43LjkuNQ==
