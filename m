From: Chul Lee <chur.lee@samsung.com>
Subject: Re: (2)  [PATCH 2/2] f2fs: add brackets for macros
Date: Tue, 15 Jan 2019 11:26:00 +0900
Message-ID: <20190115022600epcms2p12e4f4b3bc28a42b140c3f40854d183d2@epcms2p1>
References: <7b6ac61f-a934-5f08-148b-17661cf9ad34@huawei.com>
 <20190114140514.197758-1-shengyong1@huawei.com>
 <20190114140514.197758-2-shengyong1@huawei.com>
 <CGME20190115015747epcas1p33dc7f43481d4d12b6103874d185466d1@epcms2p1>
Reply-To: chur.lee@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chur.lee@samsung.com>) id 1gjEQl-0002h5-N9
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 15 Jan 2019 02:26:19 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gjEQb-002fZj-0x
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 15 Jan 2019 02:26:19 +0000
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20190115022601epoutp031338741a23590ab31835db21b33028c6~55Hp7vZAw1655316553epoutp03h
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 15 Jan 2019 02:26:01 +0000 (GMT)
In-Reply-To: <7b6ac61f-a934-5f08-148b-17661cf9ad34@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "jaegeuk@kernel.org" <jaegeuk@kernel.org>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

wqANCsKgDQotLS0tLS0tLS0gT3JpZ2luYWwgTWVzc2FnZSAtLS0tLS0tLS0NClNlbmRlciA6IENo
YW8gWXXCoDx5dWNoYW8wQGh1YXdlaS5jb20+DQpEYXRlICAgOiAyMDE5LTAxLTE1IDEwOjU3IChH
TVQrOSkNClRpdGxlICA6IFJlOiBbZjJmcy1kZXZdIFtQQVRDSCAyLzJdIGYyZnM6IGFkZCBicmFj
a2V0cyBmb3IgbWFjcm9zDQpUbyA6IFNoZW5nIFlvbmc8c2hlbmd5b25nMUBodWF3ZWkuY29tPiwg
amFlZ2V1a0BrZXJuZWwub3JnDQpDQyA6IGxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9y
Z2UubmV0DQrCoA0KT27CoDIwMTkvMS8xNMKgMjI6MDUswqBTaGVuZ8KgWW9uZ8Kgd3JvdGU6DQo+
wqBTaWduZWQtb2ZmLWJ5OsKgU2hlbmfCoFlvbmfCoDxzaGVuZ3lvbmcxQGh1YXdlaS5jb20+DQrC
oA0KUmV2aWV3ZWQtYnk6wqBDaGFvwqBZdcKgPHl1Y2hhbzBAaHVhd2VpLmNvbT4NCsKgDQpUaGFu
a3MsDQrCoA0KwqANCsKgDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXw0KTGludXgtZjJmcy1kZXZlbMKgbWFpbGluZ8KgbGlzdA0KTGludXgtZjJmcy1kZXZl
bEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQNCmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xp
c3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwNCsKgCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QK
TGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
