Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B14CC9830D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Sep 2026 01:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EJSo91ZNZk30hot/jQQArar0Maa9lPBO7/alZfkHoIA=; b=O02gXFIJ9BvvAo/49ZRMsJjpbi
	Pv+Mkw+UF6dj964bmYpr+3G8732LEyJzh//O8aa3YbihOSecU2NE9YTOxldvxloDNUdVsmCq2OUuL
	B42lpI79veOEmCWYUlrFoRoDWoV4knTdke0nkQ357Jvsqhg1wrA0zTECaG+7jmloD5PQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x9Yeg-0005kI-37;
	Thu, 24 Sep 2026 01:53:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <Zhiguo.Niu@unisoc.com>) id 1x9Yed-0005k3-PT
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 01:53:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MRKJ1vQk4EzZyX2zAiVgUqdcDCMqfNg3jDzgN/GS/sw=; b=ZorCISL6BlndDdPH3Pum1Sluuu
 5lkEfRS148Ydo5/kJ7m4bfX/btDO++Nl/EuUsaEIToCt4BcECY/7DGgjlgS2+Cip2EgC16wiKpeyd
 p0dYyYFqdTypeEPX1YKHAHidxtcz+UXt8vY7z4hOA7gQG7DdjD6p/tugdb0XQm+z7Y5I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MRKJ1vQk4EzZyX2zAiVgUqdcDCMqfNg3jDzgN/GS/sw=; b=N
 7Qsd53Veqe/38xqztb/m8S50B47ul0G1Fw/cQUafD9iOplGZX/DWXa/XVN9GnfnUCj0ruhFgF+jEB
 d44XXNfQ9D9ISRmwzk8vVIRk2t8KHH4h9uMv4Z3WivEA8PTpn9XjSX8qGIHnwV6wnAXd+NlB714Jn
 +TV65i5YIk1sLBZ8=;
Received: from mx1.unisoc.com ([222.66.158.135] helo=SHSQR01.spreadtrum.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x9Yed-0007en-1I for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 01:53:44 +0000
Received: from dlp.unisoc.com ([10.29.3.86])
 by SHSQR01.spreadtrum.com with ESMTPS id 68O1qx21014968
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Thu, 24 Sep 2026 09:52:59 +0800 (+08)
 (envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (BJMBX02.spreadtrum.com [10.0.64.8])
 by dlp.unisoc.com (SkyGuard) with ESMTPS id 4hqxc63GQQz2N3TjZ;
 Thu, 24 Sep 2026 09:50:14 +0800 (CST)
Received: from bj08434pcu10.spreadtrum.com (10.0.70.50) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Thu, 24 Sep 2026 09:52:56 +0800
To: <jaegeuk@kernel.org>, <chao@kernel.org>
Date: Thu, 24 Sep 2026 09:52:12 +0800
Message-ID: <20260924015213.1196491-1-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Originating-IP: [10.0.70.50]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 68O1qx21014968
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
 s=default; t=1790214793;
 bh=MRKJ1vQk4EzZyX2zAiVgUqdcDCMqfNg3jDzgN/GS/sw=;
 h=From:To:CC:Subject:Date;
 b=yL/zweCwGse6YZqLoHAGBaY5bFLzT9TmKEOHmDDiSJygkebiM3T5DGlrs02UYXY39
 +g/9IRIuhNu8FSrBajttHWOxMGTnHV6Eh2nADaF2JWceqXtAz/C1gu2c2MYh28W45x
 YQJ3lkkPdppy/m9zxJ8YcvZdL7RIENl0mg2u02Yjxv2jrmQFwKu+GkL0JNiUpAm/A4
 ZyUwhQFwN7va6RmZaVvYRjUDDoE68GqsM5/W4/TG3cRrOXLJWrz53tDINM+Y+QU5PS
 pWbHy9foHy2Jdc1Ey+9fxiluObrXDKt4btSFnO+iBIoWYl1JMt48XP4huueoCMFMXW
 GG0uGqXD4jBQQ==
X-Headers-End: 1x9Yed-0007en-1I
Subject: [f2fs-dev] [PATCH 1/2] f2fs: simplify node footer check in
 f2fs_cache_write_end_io
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
From: Zhiguo Niu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: ke.wang@unisoc.com, zhiguo.niu@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

In f2fs_cache_write_end_io(), the return value of
f2fs_sanity_check_node_footer() was ignored and a separate
f2fs_bug_on() only verified the node index. Pass the sanity
check result directly into f2fs_bug_on() so that a corrupted
node footer triggers the assertion, and drop the redundant
index check.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/data.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6d4ba5e77906..f203f99fc10a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -424,9 +424,8 @@ static void f2fs_cache_write_end_io(struct bio *bio)
 		entry->next_entry = NULL;
 
 		if (f2fs_is_node_cache(entry)) {
-			f2fs_sanity_check_node_footer(sbi, entry,
-				entry->index, NODE_TYPE_REGULAR, true);
-			f2fs_bug_on(sbi, entry->index != nid_of_node(sbi, entry));
+			f2fs_bug_on(sbi, f2fs_sanity_check_node_footer(sbi,
+				entry, entry->index, NODE_TYPE_REGULAR, true));
 		}
 		if (f2fs_in_warm_node_list(sbi, entry))
 			f2fs_del_fsync_node_entry(sbi, entry);
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
