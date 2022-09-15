Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90DFECAAD3
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 15 Sep 2022 07:26:20 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oYjGA-0007PX-Eg;
	Thu, 15 Sep 2022 07:26:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <Zhiguo.Niu@unisoc.com>) id 1oYjG8-0007PO-O7
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Sep 2022 07:26:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tdIuOP1I0hnkSr8f8U9gRCA78yZ5f39cIkNkskC7XT4=; b=fKrgAupzzN0j4iq4Oh31U13X/W
 Cp69K9LolRVfH5x59znOOLYBugavFxPtsHe0beglxO+Yqppab6Y7O9q7FG0loBAdO+M0YP2UA9Q6F
 +bMV8sQAHZ7s3BxsJu8/mMx77CEbttTa7OcYHXi+WnsH8SXedFSzwq6I781gJo/xVbaw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
 Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tdIuOP1I0hnkSr8f8U9gRCA78yZ5f39cIkNkskC7XT4=; b=T
 7cdYwBPF6PDyVtwYlvrONCxKH0jCOti4oq2tsFv+K7d3erEggESbCg3a5AzSz9kbg8YcJCkQ10di0
 sEP8hS6LNy31xORLsBJMx39Cb72u/QeIBIk3Zp/Pi6+CzlHPqFib2flYPg+O+tXeBzRq0W3ai4M1s
 4gE48zFC4JQO6YbY=;
Received: from mx1.unisoc.com ([222.66.158.135] helo=SHSQR01.unisoc.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oYjGK-0003Ma-49 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Sep 2022 07:26:17 +0000
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
 by SHSQR01.unisoc.com with ESMTP id 28F6H07W013303
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 15 Sep 2022 14:17:00 +0800 (CST)
 (envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHSend.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
 by SHSQR01.spreadtrum.com with ESMTPS id 28F6GL6q009931
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
 Thu, 15 Sep 2022 14:16:21 +0800 (CST)
 (envelope-from Zhiguo.Niu@unisoc.com)
Received: from bj08434pcu.spreadtrum.com (10.0.74.109) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 15 Sep 2022 14:16:21 +0800
From: "zhiguo.niu" <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>,
 <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Date: Thu, 15 Sep 2022 14:16:13 +0800
Message-ID: <1663222573-27702-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [10.0.74.109]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 28F6GL6q009931
X-Headers-End: 1oYjGK-0003Ma-49
Subject: [f2fs-dev] [PATCH Vx 1/1] f2fs: fix some error handling case in gc
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: lvqiang.huang@unisoc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

RHVyaW5nIEdDLCBpZiBzZWdtZW50IHR5cGUgc3RvcmVkIGluIFNTQSBhbmQgU0lUIGlzIGluY29u
c2lzdGVudCwKd2Ugc2V0IFNCSV9ORUVEX0ZTQ0sgZmlyc3QgYW5kIHRoZW4gc3RvcCBjaGVja3Bv
aW50LCB0aGlzIHdpbGwKY2F1c2UgdGhlIGZvbGxvd2luZyBpc3N1ZXM6CjEuIFNCSV9ORUVEX0ZT
Q0sgY2FuIG5vdCBiZSBzZXQgdG8gZmxhc2ggdHJ1bHkgYmVjYXVzZSBvZiBjaGVja3BvaW50Cmhh
cyBiZWVuIHN0b3BwZWQuCjIuIFdpbGwgY2F1c2UgbW9yZSBFSU8gZXJyb3IgYmVjYXVzZSBvZiBD
UF9FUlJPUl9GTEFHIGlzIHNldCBpbgpmMmZzX3N0b3BfY2hlY2twb2ludCwgdGhpcyBpcyBub3Qg
cmVhc29uYWJsZS4KClNvIHdlIGZpeCB0aGlzIGVycm9yIGhhbmRsaW5nIGNhc2UgYnkgcmVjb3Jk
aW5nIGN1cnJlbnQgdmljdGltIHNlZ21lbnQKYXMgaW52YWxpZCBmb3IgZ2MuCgpTaWduZWQtb2Zm
LWJ5OiB6aGlndW8ubml1IDx6aGlndW8ubml1QHVuaXNvYy5jb20+Ci0tLQogZnMvZjJmcy9nYy5j
IHwgMTEgKysrKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvZjJmcy9nYy5jIGIvZnMvZjJmcy9nYy5jCmluZGV4
IGQ1ZmI0MjZlMDc0Ny4uNjZiZGYyNjc4YjVlIDEwMDY0NAotLS0gYS9mcy9mMmZzL2djLmMKKysr
IGIvZnMvZjJmcy9nYy5jCkBAIC0xNzAwLDEwICsxNzAwLDEzIEBAIHN0YXRpYyBpbnQgZG9fZ2Fy
YmFnZV9jb2xsZWN0KHN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSwKCiAgICAgICAgICAgICAgICBz
dW0gPSBwYWdlX2FkZHJlc3Moc3VtX3BhZ2UpOwogICAgICAgICAgICAgICAgaWYgKHR5cGUgIT0g
R0VUX1NVTV9UWVBFKCgmc3VtLT5mb290ZXIpKSkgewotICAgICAgICAgICAgICAgICAgICAgICBm
MmZzX2VycihzYmksICJJbmNvbnNpc3RlbnQgc2VnbWVudCAoJXUpIHR5cGUgWyVkLCAlZF0gaW4g
U1NBIGFuZCBTSVQiLAotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzZWdubywgdHlw
ZSwgR0VUX1NVTV9UWVBFKCgmc3VtLT5mb290ZXIpKSk7Ci0gICAgICAgICAgICAgICAgICAgICAg
IHNldF9zYmlfZmxhZyhzYmksIFNCSV9ORUVEX0ZTQ0spOwotICAgICAgICAgICAgICAgICAgICAg
ICBmMmZzX3N0b3BfY2hlY2twb2ludChzYmksIGZhbHNlKTsKKyNpZmRlZiBDT05GSUdfRjJGU19D
SEVDS19GUworICAgICAgICAgICAgICAgICAgICAgICBpZiAoIXRlc3RfYW5kX3NldF9iaXQoc2Vn
bm8sIFNJVF9JKHNiaSktPmludmFsaWRfc2VnbWFwKSkgeworICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGYyZnNfZXJyKHNiaSwgIkluY29uc2lzdGVudCBzZWdtZW50ICgldSkgdHlwZSBb
JWQsICVkXSBpbiBTU0EgYW5kIFNJVCIsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzZWdubywgdHlwZSwgR0VUX1NVTV9UWVBFKCgmc3VtLT5mb290ZXIpKSk7CisgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc2V0X3NiaV9mbGFnKHNiaSwgU0JJX05FRURfRlND
Syk7CisgICAgICAgICAgICAgICAgICAgICAgIH0KKyNlbmRpZgogICAgICAgICAgICAgICAgICAg
ICAgICBnb3RvIHNraXA7CiAgICAgICAgICAgICAgICB9CgotLQoyLjE3LjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCiBUaGlzIGVtYWlsIChpbmNsdWRpbmcgaXRzIGF0dGFjaG1l
bnRzKSBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgcGVyc29uIG9yIGVudGl0eSB0byB3aGljaCBp
dCBpcyBhZGRyZXNzZWQgYW5kIG1heSBjb250YWluIGluZm9ybWF0aW9uIHRoYXQgaXMgcHJpdmls
ZWdlZCwgY29uZmlkZW50aWFsIG9yIG90aGVyd2lzZSBwcm90ZWN0ZWQgZnJvbSBkaXNjbG9zdXJl
LiBVbmF1dGhvcml6ZWQgdXNlLCBkaXNzZW1pbmF0aW9uLCBkaXN0cmlidXRpb24gb3IgY29weWlu
ZyBvZiB0aGlzIGVtYWlsIG9yIHRoZSBpbmZvcm1hdGlvbiBoZXJlaW4gb3IgdGFraW5nIGFueSBh
Y3Rpb24gaW4gcmVsaWFuY2Ugb24gdGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgb3IgdGhlIGlu
Zm9ybWF0aW9uIGhlcmVpbiwgYnkgYW55b25lIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lw
aWVudCwgb3IgYW4gZW1wbG95ZWUgb3IgYWdlbnQgcmVzcG9uc2libGUgZm9yIGRlbGl2ZXJpbmcg
dGhlIG1lc3NhZ2UgdG8gdGhlIGludGVuZGVkIHJlY2lwaWVudCwgaXMgc3RyaWN0bHkgcHJvaGli
aXRlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIGRvIG5v
dCByZWFkLCBjb3B5LCB1c2Ugb3IgZGlzY2xvc2UgYW55IHBhcnQgb2YgdGhpcyBlLW1haWwgdG8g
b3RoZXJzLiBQbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIHBlcm1hbmVu
dGx5IGRlbGV0ZSB0aGlzIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIGlmIHlvdSByZWNlaXZl
ZCBpdCBpbiBlcnJvci4gSW50ZXJuZXQgY29tbXVuaWNhdGlvbnMgY2Fubm90IGJlIGd1YXJhbnRl
ZWQgdG8gYmUgdGltZWx5LCBzZWN1cmUsIGVycm9yLWZyZWUgb3IgdmlydXMtZnJlZS4gVGhlIHNl
bmRlciBkb2VzIG5vdCBhY2NlcHQgbGlhYmlsaXR5IGZvciBhbnkgZXJyb3JzIG9yIG9taXNzaW9u
cy4K5pys6YKu5Lu25Y+K5YW26ZmE5Lu25YW35pyJ5L+d5a+G5oCn6LSo77yM5Y+X5rOV5b6L5L+d
5oqk5LiN5b6X5rOE6Zyy77yM5LuF5Y+R6YCB57uZ5pys6YKu5Lu25omA5oyH54m55a6a5pS25Lu2
5Lq644CC5Lil56aB6Z2e57uP5o6I5p2D5L2/55So44CB5a6j5Lyg44CB5Y+R5biD5oiW5aSN5Yi2
5pys6YKu5Lu25oiW5YW25YaF5a6544CC6Iul6Z2e6K+l54m55a6a5pS25Lu25Lq677yM6K+35Yu/
6ZiF6K+744CB5aSN5Yi244CBIOS9v+eUqOaIluaKq+mcsuacrOmCruS7tueahOS7u+S9leWGheWu
ueOAguiLpeivr+aUtuacrOmCruS7tu+8jOivt+S7juezu+e7n+S4reawuOS5heaAp+WIoOmZpOac
rOmCruS7tuWPiuaJgOaciemZhOS7tu+8jOW5tuS7peWbnuWkjemCruS7tueahOaWueW8j+WNs+WI
u+WRiuefpeWPkeS7tuS6uuOAguaXoOazleS/neivgeS6kuiBlOe9kemAmuS/oeWPiuaXtuOAgeWu
ieWFqOOAgeaXoOivr+aIlumYsuavkuOAguWPkeS7tuS6uuWvueS7u+S9lemUmea8j+Wdh+S4jeaJ
v+aLhei0o+S7u+OAggoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlz
dHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xp
c3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
