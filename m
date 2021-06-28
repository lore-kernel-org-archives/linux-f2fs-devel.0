Return-Path: <SRS0=QpjO=LW=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEDEC2B9F4
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Jun 2021 13:06:13 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EC22619AB
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Jun 2021 13:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC22619AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lxqxl-0008IN-PX; Mon, 28 Jun 2021 13:06:09 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <changfengnan@vivo.com>) id 1lxqxk-0008IG-B3
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Jun 2021 13:06:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dYafs5kfin+Bo3Oph0RikhVDLy0JGfbQmdbgUsf1wvw=; b=maM8gRCF3KNs4o6f++DQsaxUik
 qKtR33PFJD8jF94xlNeF8v/EtpcfNX47iScCkwyo+Bz2rh+jmoaeTRnVRJ0WBtBzdO2pQCa00zHT6
 phMT6pYmT715itBX4bedSANJBxFP6VKV8OXkr0DbOZ9syhgZ0RydrB1drGa0boRzYqbk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dYafs5kfin+Bo3Oph0RikhVDLy0JGfbQmdbgUsf1wvw=; b=S
 HGzAywADGlKOI4Zk/5KqtmMgFPRk34N4AtJPqK8g7Hxfth8CpWDRfxJ98764Ln+AFwxyqjKx3In3J
 PDNpvtSjQWQsIm/C0SuoUs5KyRdBhT3oBao9lAEfACUpRGLV2ty8HdWyOmUzo1HCG9r1Tqmtj5QlF
 GjB5O7PNnDeC0NqM=;
Received: from mail-m121144.qiye.163.com ([115.236.121.144])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lxqxd-001sRx-VN
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Jun 2021 13:06:10 +0000
DKIM-Signature: a=rsa-sha256;
 b=mzV1eSyExtUOwA2Gryg3oB/Cmw2UyzezXAw1EIIQjsGgJryMbJygAn1NOQC84dnFP/k3731dmFAluFYyQTAlBVn4WpXZyvmV0uQ/YFQsmNAw3h9Y8PIpaYhMO+gG5WkGDQHfMLQyJqz48cBlJ5rdBW/UBstv8MdYlPMfUwCl7og=;
 c=relaxed/relaxed; s=default; d=vivo.com; v=1;
 bh=dYafs5kfin+Bo3Oph0RikhVDLy0JGfbQmdbgUsf1wvw=;
 h=date:mime-version:subject:message-id:from;
Received: from comdg01144017.vivo.xyz (unknown [218.104.188.164])
 by mail-m121144.qiye.163.com (Hmail) with ESMTPA id 026A9AC02C7;
 Mon, 28 Jun 2021 21:05:51 +0800 (CST)
From: Fengnan Chang <changfengnan@vivo.com>
To: jaegeuk@kernel.org, chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 28 Jun 2021 21:05:50 +0800
Message-Id: <20210628130550.39696-1-changfengnan@vivo.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
 oVCBIfWUFZGh0ZSlYZHx9LSRlPGE8fSUhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
 hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nz46PDo*MD9DSTRJNCEBGEIc
 KzdPCSJVSlVKTUlPQ0NOTk5JTklMVTMWGhIXVRgTGhUcHR4VHBUaFTsNEg0UVRgUFkVZV1kSC1lB
 WUlKQ1VKS09VSkNDVUpNT1lXWQgBWUFKTUlPNwY+
X-HM-Tid: 0a7a52b9e41eb039kuuu026a9ac02c7
X-Headers-End: 1lxqxd-001sRx-VN
Subject: [f2fs-dev] [PATCH] f2fs: compress: allow write compress released
 file after truncate to zero
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
Cc: Fengnan Chang <changfengnan@vivo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

We should allow write compress released file after truncate to zero.

Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
---
 fs/f2fs/file.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6afd4562335f..b91ae8f751c5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -730,9 +730,13 @@ int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock)
 	 * for compressed file, only support cluster size
 	 * aligned truncation.
 	 */
-	if (f2fs_compressed_file(inode))
+	if (f2fs_compressed_file(inode)) {
 		free_from = round_up(from,
 				F2FS_I(inode)->i_cluster_size << PAGE_SHIFT);
+		if (!free_from)
+			clear_inode_flag(inode, FI_COMPRESS_RELEASED);
+	}
+
 #endif
 
 	err = f2fs_do_truncate_blocks(inode, free_from, lock);
-- 
2.29.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
