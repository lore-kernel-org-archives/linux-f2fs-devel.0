Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF00CA9EC5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:
	List-Id:Subject:References:Date:Message-ID:To:From:Mime-Version:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=xQNZy/v/0zC1CtXQULRgfRxgsCD4+JMLbX33MNS7ves=; b=gPXToL5jFOZXUSnEy6ISeSRin9
	aba5PpKrmyPpqdolLrO7LlUi8u3lj9IuogMvnn+a860vsVoSLjpcb9G698eMM+ZU8HSoZlE13z7OC
	6F/vOMfqBNCg2dJ/4WhJHgSY49zsbxJzBleezy21KAI5wXHgDG481LWlxuMDuu3sYEAo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGALx-00028Z-L7;
	Mon, 12 Oct 2026 07:21:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <keosung.park@samsung.com>) id 1xGALv-00028R-Ic
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 07:21:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Content-Transfer-Encoding:
 Date:Message-ID:CC:To:From:Sender:Reply-To:Subject:Mime-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7SLteVdjPiEHdE5sddmk61hF6DXbPHqRUJWK2W3/8yk=; b=nRAjKc8nHWxrCxzbEa5ezT3va7
 fIRe+rxhhFR87h6fovqmZc0cVN2oQQJCPIw1gjPyo3AHOKjtwOiygkC/nEC5LKWh6zbg/psMLATR0
 ZKYXwXBKbllh+6hGVY+s8s8LjCepd2CfBngg5zRUMD/jDnVvb1Nf02KZaQkI/lxuIX68=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:Content-Type:Content-Transfer-Encoding:Date:Message-ID:CC:To:
 From:Sender:Reply-To:Subject:Mime-Version:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7SLteVdjPiEHdE5sddmk61hF6DXbPHqRUJWK2W3/8yk=; b=m
 VHQqOHU0o5I43Jfk+jUrQn7NgKKZPtn22BF6d68stT2JDlRldWsE/0ji9BOs2Do9Roux0fwNeuWwZ
 xjRcqiXHpD75Fm1sy98AgaIA4c8SfBC7KbwSfdWPS2X0NRwUqxYypoA25N+caZP7Oyp0UC+BZYGkW
 D10DvG67dyuyG2qE=;
Received: from mailout4.samsung.com ([203.254.224.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGALv-0000Vm-2K for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 07:21:44 +0000
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20261012070156epoutp043652abfb94059c49597c434184afc01a~dtimbXd5m0602506025epoutp04I
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 12 Oct 2026 07:01:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20261012070156epoutp043652abfb94059c49597c434184afc01a~dtimbXd5m0602506025epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1791788516;
 bh=7SLteVdjPiEHdE5sddmk61hF6DXbPHqRUJWK2W3/8yk=;
 h=Subject:Reply-To:From:To:CC:Date:References:From;
 b=Ayab69z4B8bLubdHG2lTd1uRwyoPUHGNP8tt7g3tGU9u2eI1g6/JFc5EfknA433Z1
 jHstcRNCUcaIaWxbsUSe0yZ8cgAAFzqdDr7bkCVn5OfCegVjNwBg5erPqFLPwsCl/d
 JEIYJe29jWda26RI2ozRW9GyRBrn0kcKZBsrorW0=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPS id
 20261012070155epcas2p3b98e22081fb305528e3e2113cdf58680~dtil3xUgg0609606096epcas2p3R;
 Mon, 12 Oct 2026 07:01:55 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.38.205]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4j37gR59V3z6B9mD; Mon, 12 Oct
 2026 07:01:55 +0000 (GMT)
Mime-Version: 1.0
From: Keoseong Park <keosung.park@samsung.com>
To: "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "chao@kernel.org"
 <chao@kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20261012070155epcms2p12175ed226bd55689c386338460be6d9d@epcms2p1>
Date: Mon, 12 Oct 2026 16:01:55 +0900
X-CMS-MailID: 20261012070155epcms2p12175ed226bd55689c386338460be6d9d
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261012070155epcms2p12175ed226bd55689c386338460be6d9d
References: <CGME20261012070155epcms2p12175ed226bd55689c386338460be6d9d@epcms2p1>
X-Headers-End: 1xGALv-0000Vm-2K
Subject: [f2fs-dev] [PATCH] f2fs: do not discard valid segments with
 discard_unit=section
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
Reply-To: keosung.park@samsung.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

With discard_unit=section, f2fs_clear_prefree_segments() widens a run
of prefree segments to section boundaries, but only LFS mode checks the
sections for valid blocks afterwards. In adaptive mode with large
sections the widened range is discarded as it is, including segments
that are still valid, and their data is lost.

Check each section whenever the range was widened over large sections.

Testcase:
- mkfs.f2fs -f -s 2 /dev/vda
- mount -o discard,discard_unit=section /dev/vda /mnt/f2fs
- for i in 0 1 2 3 4 5; do
      dd if=/dev/urandom of=/mnt/f2fs/k$i bs=2M count=1 conv=fsync; done
- rm /mnt/f2fs/k0 /mnt/f2fs/k2 /mnt/f2fs/k4; sync
- umount /mnt/f2fs
- mount -o discard,discard_unit=section /dev/vda /mnt/f2fs

Before, k1, k3 and k5 are lost after the remount, or the umount hits
the f2fs_bug_on() in __check_sit_bitmap() with CONFIG_F2FS_CHECK_FS.
After, they are intact.

Fixes: 4f993264fe29 ("f2fs: introduce discard_unit mount option")
Signed-off-by: Keoseong Park <keosung.park@samsung.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 794e0d99fc7..2e1502c5571 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2325,7 +2325,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 
 		/* Should cover 2MB zoned device for zone-based reset */
 		if (!f2fs_sb_has_blkzoned(sbi) &&
-		    (!f2fs_lfs_mode(sbi) || !__is_large_section(sbi))) {
+		    (!section_alignment || !__is_large_section(sbi))) {
 			f2fs_issue_discard(sbi, START_BLOCK(sbi, start),
 				SEGS_TO_BLKS(sbi, end - start));
 			continue;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
