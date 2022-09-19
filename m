Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EA9C32771
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Sep 2022 02:32:22 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oa6a3-0004ZQ-Qr;
	Mon, 19 Sep 2022 02:32:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <yonggil.song@samsung.com>) id 1oa6a1-0004ZJ-9r
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Sep 2022 02:32:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Content-Transfer-Encoding:
 Date:Message-ID:CC:To:From:Sender:Reply-To:Subject:Mime-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zPbJipuVGWci7Qgh4gwml2SBskXo8M9wUc+7sD7FCgo=; b=EIFOnbik9/o9PNDKgpmkKI1w9m
 uG/OZeZ1TgPmzJCfLsz9Eqf3uRLL8b2mNUx1n2quE+DZ0RrxBFET7ASNi89On1wxkggGYBZZcl7+L
 YIVQs/B1QhW+YXewRh9jQsuqvbAHHoolm2xcwMqOMaCo/IKwjdLMf3mIQIg9KuWBQgVg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:Content-Type:Content-Transfer-Encoding:Date:Message-ID:CC:To:
 From:Sender:Reply-To:Subject:Mime-Version:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zPbJipuVGWci7Qgh4gwml2SBskXo8M9wUc+7sD7FCgo=; b=J
 Y+3pfASm3YagElSaJozXQ6k2RFZPBFnkF0j5hmkh+JCnFlFDgses5nXYdxWHzWEECY/l5bxUE2yHR
 7S/1UjEe/N0sV0m3El6HQVyCWwXtUaZrbTHiId0wYGe57zzKIJ7D0XgIc+CNqJwM9ReD/iHhptRPX
 vZ58oAKU2/8mwcxM=;
Received: from mailout3.samsung.com ([203.254.224.33])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oa6Zs-00CmQY-WA for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Sep 2022 02:32:17 +0000
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20220919023157epoutp03ae435c52a354ab5aaf9c70f24500a7a7~WIjOZpUNk0265102651epoutp03f
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 19 Sep 2022 02:31:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20220919023157epoutp03ae435c52a354ab5aaf9c70f24500a7a7~WIjOZpUNk0265102651epoutp03f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1663554717;
 bh=zPbJipuVGWci7Qgh4gwml2SBskXo8M9wUc+7sD7FCgo=;
 h=Subject:Reply-To:From:To:CC:Date:References:From;
 b=dwGiInkf1EuARgYT44vRuhSRB08FWLeeohQzDrEa3JnWxfQibs7zFzr5eNoNB0Bhb
 pY3zjyYacWuDensgurxhCiHJPrCDz0Ru9da6MncpeqZWRlQHs1T+aCy1o4NyZMUPDT
 3MPem6ysqiweFlUneyVZUS4NDo7K1HjjmwSHrGD0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20220919023155epcas2p3ea3da8c2a7eef4e7f003f01970db5158~WIjNCn3M82051320513epcas2p3B;
 Mon, 19 Sep 2022 02:31:55 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.99]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4MW7wq4N5Sz4x9QG; Mon, 19 Sep
 2022 02:31:55 +0000 (GMT)
X-AuditID: b6c32a46-36bff70000004e8a-47-6327d49bae37
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 1A.D4.20106.B94D7236; Mon, 19 Sep 2022 11:31:55 +0900 (KST)
Mime-Version: 1.0
From: Yonggil Song <yonggil.song@samsung.com>
To: "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "chao@kernel.org"
 <chao@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220919023155epcms2p3f7040c348b5351a731f98c3f9c3a6847@epcms2p3>
Date: Mon, 19 Sep 2022 11:31:55 +0900
X-CMS-MailID: 20220919023155epcms2p3f7040c348b5351a731f98c3f9c3a6847
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7bCmhe7sK+rJBle/ylucnnqWyeLJ+lnM
 FpcWuVtMPX+EyYHFY9OqTjaP3Qs+M3n0bVnFGMAclW2TkZqYklqkkJqXnJ+SmZduq+QdHO8c
 b2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA7RNSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKr
 lFqQklNgXqBXnJhbXJqXrpeXWmJlaGBgZApUmJCd8erfdvaCPtaKBd/3MjUwNrJ0MXJySAiY
 SPy50cXcxcjFISSwg1Hi16d+ti5GDg5eAUGJvzuEQWqEBeQlTk3sYQaxhQSUJK4d6GWBiOtL
 bF68jB3EZhPQlfi7YTmYLSKwklGi5Uk4iM0soC2xcfZZJohdvBIz2p9C7ZWW2L58KyOErSHx
 Y1kvM4QtKnFz9Vt2GPv9sflQNSISrffOQtUISjz4uRsqLimx6NB5qPn5En9XXGeDsGsktja0
 QcX1Ja51bATbyyvgK/H5yXKwOSwCqhIvnoDM5ACqcZFYvz0B4mR5ie1v54CFmQU0Jdbv0oeo
 UJY4cosFooJPouPwX3aYp3bMewK1SE1i86bNrBC2jMSFx21QR3pIfPjykhUSgIESt5t+ME1g
 VJiFCOZZSPbOQti7gJF5FaNYakFxbnpqsVGBETxmk/NzNzGCU52W2w7GKW8/6B1iZOJgPMQo
 wcGsJMKr6qmSLMSbklhZlVqUH19UmpNafIjRFOjhicxSosn5wGSbVxJvaGJpYGJmZmhuZGpg
 riTO66LNmCwkkJ5YkpqdmlqQWgTTx8TBKdXANPedj8e0pVoZvDuqFnlPveya/eKdgZ3s5LWv
 As/p9m/r+8V3RLT+YoHExJMMNlEsl1+HB+1u4//9cfPSSwsebL+426PI8przqdCUY/1uq+eZ
 uk20O9owR1+KLeTHnwfpDOoZSycVH3G8FtH9q8rq0/uEH0Ve2b5MNb57uatvHJXYeXvzFeO8
 Xz5hn4S5tY8WT383ab3QhxkrT23K28Zbe2HiE3YW2cORah/cFnMfWJ95MN36iYoPS39JeNQj
 PtPya0eLPAXrLwtwnp0hseE362X2/Ld77GS8em90PdXdFNq+ePWXHdm9WoEyYhHZnk69v5oP
 X1wruzNPtS3k6nVpZfUtT3uWtsYFOX3dfn9tpBJLcUaioRZzUXEiAF9si8n+AwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220919023155epcms2p3f7040c348b5351a731f98c3f9c3a6847
References: <CGME20220919023155epcms2p3f7040c348b5351a731f98c3f9c3a6847@epcms2p3>
X-Headers-End: 1oa6Zs-00CmQY-WA
Subject: [f2fs-dev] [PATCH] f2fs: fix typo
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
Reply-To: yonggil.song@samsung.com
Cc: Yonggil Song <yonggil.song@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net



Fix typo in f2fs.h
Detected by Jaeyoon Choi

Signed-off-by: Yonggil Song 
---
 fs/f2fs/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index eddfd35eadb6..661096be59d1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -274,7 +274,7 @@ enum {
 	ORPHAN_INO,		/* for orphan ino list */
 	APPEND_INO,		/* for append ino list */
 	UPDATE_INO,		/* for update ino list */
-	TRANS_DIR_INO,		/* for trasactions dir ino list */
+	TRANS_DIR_INO,		/* for transactions dir ino list */
 	FLUSH_INO,		/* for multiple device flushing */
 	MAX_INO_ENTRY,		/* max. list */
 };
-- 
2.34.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
