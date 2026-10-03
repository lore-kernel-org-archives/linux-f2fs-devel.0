Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A561CA5FEC
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  3 Oct 2026 13:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:In-Reply-To:References:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3cdIfDCpJ8AjXaBnsIjnLP4pf6gDmYdPwLSFaGgA3XY=; b=lskCQtjY2ym8uFuVXTbhzVy3mo
	9tblzR10th+4DK3IP5KNl5Br6vEwfuPhVqShCpANGN2yYWPNK1axJqRPIOCnxYN0h/KNPYel3L1wL
	5xcpr0/VT3Ryq5tTks50JfvHs6NtuAnSmqcZRQBrzKekV0WpSwzV18Mw16QVQnJ6t708=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xD0DV-0004x0-MC;
	Sat, 03 Oct 2026 13:55:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhaonanzhe@xiaomi.com>) id 1xD0DU-0004wq-DH
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 13:55:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v853H5nbgkgr1qTo8CTt2cgimrFmXWP9hw3M8VPC68c=; b=TysyBfhocFZ6OesjCqOi3ek5Oi
 UsPyZq4W4oYZuEt7JlA9wqHZvj5MNY4M+x+/E0lBWnQR+UBRMnRwKYoQsf1/yanvTbnr4IbIluPE2
 mfGAsvbzCHm7C561GBwL0h8ft41WXNghq8Bd8e5q5XwNhsDr6ewuVrCQEXzRW3G4p8UQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:
 References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=v853H5nbgkgr1qTo8CTt2cgimrFmXWP9hw3M8VPC68c=; b=My9MfRRyrIX2O/7XZVRBdMS2NT
 wYgC4/IiYChBYDwoaBaHOCopdq7Bbfg+/1w+ZFnV38RNvppY3qauP+CCFPWywQf1F7fXgayFr5Xzb
 E0ayT3Iy+loqwSMfZwzIQqBbjZIvc2IeCBcLLEMlCBpZ/1IzCOOfY7LU23nPnjFr+j68=;
Received: from outboundhk.mxmail.xiaomi.com ([118.143.206.90])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtp (Exim 4.95)
 id 1xD0DU-0007Bh-Hd for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 13:55:57 +0000
X-CSE-ConnectionGUID: doLpPFXHT3SmBJwqDKhSFg==
X-CSE-MsgGUID: SHV/oX2PSWCdmyWyROdTzA==
X-IronPort-AV: E=Sophos;i="6.27,138,1786982400"; d="scan'208";a="164483996"
To: Jaegeuk Kim <jaegeuk@kernel.org>
Thread-Topic: [External Mail]Re: [f2fs-dev] [PATCH v2 00/14] f2fs: support &
 optimize large folios for writable files
Thread-Index: AQHdUP5ie3mQoHhgTEqJEObMEGLkWrbr0dIK
Date: Sat, 3 Oct 2026 13:40:16 +0000
Message-ID: <6ccdf4eef9b242bc96d28d511f754a30@xiaomi.com>
References: <20260915041909.2903887-1-zhaonanzhe@xiaomi.com>,
 <ar1CJBRumJ0hcNdB@google.com>
In-Reply-To: <ar1CJBRumJ0hcNdB@google.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.237.8.166]
MIME-Version: 1.0
X-Headers-End: 1xD0DU-0007Bh-Hd
Subject: [f2fs-dev] =?gb2312?b?tPC4tDogW0V4dGVybmFsIE1haWxdUmU6ICBbUEFU?=
 =?gb2312?b?Q0ggdjIgMDAvMTRdIGYyZnM6IHN1cHBvcnQgJiBvcHRpbWl6ZSBsYXJnZSBm?=
 =?gb2312?b?b2xpb3MgZm9yIHdyaXRhYmxlIGZpbGVz?=
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
From: =?gb2312?B?1dTEz9Xc?= via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: =?gb2312?B?1dTEz9Xc?= <zhaonanzhe@xiaomi.com>
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Hildenbrand <David.Hildenbrand@arm.com>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 =?gb2312?B?1cWyqQ==?= <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 =?gb2312?B?wO7F9LfJ?= <lipengfei28@xiaomi.com>,
 Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SGkgSmFlZ3VrOg0KT2guLi4uLi4sIEknbSBvbiBob2xpZGF5IGZyb20gIE9jdCAxIHRvIE9jdCA3
LHNvIHRoZSBuZXh0IHZlcnNpb24gbWF5IG5vdCBiZQ0KdGhhdCBzb29uIGFuZCBJIGFwb2xvZ2l6
ZSBmb3QgdGhhdC4gSSd3aWxsIGNhdGNoIG9uIHRoYXQgb25jZSBJJ3ZlIGdvdCB0aW1lLg0KDQpU
aGFua3MsDQpOYW56aGUNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoN
Cg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0K
DQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoN
Cg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0K
DQoNCg0KIy8qKioqKiqxvtPKvP68sMbkuL28/rqs09DQocPXuavLvrXEsaPD3NDFz6KjrL32z97T
2reiy824+MnPw+a12Na31tDB0LP2tcS49sjLu/LIutfpoaO9+9a5yM66zsbky/vIy9LUyM66ztDO
yr3KudPDo6iw/MCotauyu8/e09rIq7K/u/Kyv7fWtdjQucK2oaK4tNbGoaK78smit6KjqbG+08q8
/tbQtcTQxc+ioaPI57n7xPq07crVwcuxvtPKvP6jrMfrxPrBory0tee7sLvy08q8/s2o1qq3orz+
yMuyosm+s/2xvtPKvP6joSBUaGlzIGUtbWFpbCBhbmQgaXRzIGF0dGFjaG1lbnRzIGNvbnRhaW4g
Y29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGZyb20gWElBT01JLCB3aGljaCBpcyBpbnRlbmRlZCBv
bmx5IGZvciB0aGUgcGVyc29uIG9yIGVudGl0eSB3aG9zZSBhZGRyZXNzIGlzIGxpc3RlZCBhYm92
ZS4gQW55IHVzZSBvZiB0aGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGhlcmVpbiBpbiBhbnkgd2F5
IChpbmNsdWRpbmcsIGJ1dCBub3QgbGltaXRlZCB0bywgdG90YWwgb3IgcGFydGlhbCBkaXNjbG9z
dXJlLCByZXByb2R1Y3Rpb24sIG9yIGRpc3NlbWluYXRpb24pIGJ5IHBlcnNvbnMgb3RoZXIgdGhh
biB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpIGlzIHByb2hpYml0ZWQuIElmIHlvdSByZWNlaXZl
IHRoaXMgZS1tYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcGhvbmUg
b3IgZW1haWwgaW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSBpdCEqKioqKiovIw0KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFp
bGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8v
bGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
