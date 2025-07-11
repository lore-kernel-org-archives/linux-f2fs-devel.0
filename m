Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B0DC8303C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 11 Jul 2025 07:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PrNLhV7mbAvngldAnXh9TP3V0lHMsTPlHBBGUqOtlsw=; b=UeVWcOhpufEXjweRyizybHzMm6
	CazHEA5+pw1C6sCgSqmcHkkUwF9gPiVNnRymo44nhj7fydmCJh7tL5seHcrP0ctulJA5ba84Ppy1a
	FMzhydxuzKqKD6FOurMQgqG9wtgZ7QAka8oons89NUavsP6RraOMmpk0fINCQeY0YKnE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ua8ST-0002HM-39;
	Fri, 11 Jul 2025 07:46:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ua8SQ-0002HD-Ng
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 11 Jul 2025 07:46:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GXE1cfd0PhZrlRe83G8MeasbsGDzhTtvlCjV8eTgCKA=; b=a5ScKrLsQ/GrpJAuMTat3KgiVB
 CYFaWcfWM2e3bFAQyy9+ZaqiakUZ/03bCLbTtcYhZr/ZcCTMhGqXOQQlZOZfPZ24CtwoEFf4IPXKE
 IewwkMJ5gV8rA19osgH1NeNNgf+TT7y2a3+yOvdGDxETNQG9lwujMXoVoLYB4zFHGtd0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GXE1cfd0PhZrlRe83G8MeasbsGDzhTtvlCjV8eTgCKA=; b=mh8T5nbR8Vz81plUUTVsG/ex2t
 ddycnMek5PWlhZsp++AV/713bWAs0tnX8Dml3ceqmCwNowizc5OQ80/DncDPYsNmTf8fISNe+DYCy
 0R3+BHlnreTygAPlV9BU+fAv71S57OdtGYtBC5X2t4DyzcgriollqU3RewICBt0OyJuk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ua8SO-0002Wb-2K for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 11 Jul 2025 07:46:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A6ED2470A3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 11 Jul 2025 07:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D08C4CEF5;
 Fri, 11 Jul 2025 07:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752219962;
 bh=y6KO6ZnlSWukFCwnxKTjw51LvnPFD65LY2+fhz9Ofww=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Qek5JIYzfHeb6woVVwYFTN47npBzsGuv/I9JK5ghFVtiI//VYduez0TxgBQywiwyD
 wSfp9UoQ45uNPkeIg2kN2BDjj6kg8Aj4xrWo37yS1QJZhTM09YQQx7Z/1gUL/cB+8Y
 8gaXtDPCopQ3xQtHt6iL0gSyuaxzBfu7wL/1pNQcRmdx/I1eNaxEwKtCYz8uoftymN
 dVLm67IWsCDpDTJHfE53HLohE8gVhdV9oxpc3eyyW/h+yQ0w+OBpySFSt5AfvVn0AU
 7Kv6w68duog5SDlttQjcd7r2y9J+aYfoaSXBT5zhRTRMMf95fnZYrrUcEYkAgsMzV1
 9L95orMTxF/zg==
To: jaegeuk@kernel.org
Date: Fri, 11 Jul 2025 15:45:51 +0800
Message-ID: <20250711074551.216069-3-chao@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250711074551.216069-1-chao@kernel.org>
References: <20250711074551.216069-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1ua8SO-0002Wb-2K
Subject: [f2fs-dev] [PATCH 3/3] fsck.f2fs: fix to use strncmp to avoid
 out-of-boundary access
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Otherwise, if length of main device path is equal to MAX_PATH_LEN,
it will trigger assert() as below:

[ASSERT] (init_sb_info:1264) !strcmp((char *)sb->devs[i].path, (char *)c.devices[i].path)

This is because there is no null character in the end of devcie
path string, result in out-of-boundary access in devs.path[].

Let's use strncmp instead of strcmp to compare device path to fix
this issue.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fsck/mount.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index dbbeb56..a1c4cbb 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1261,8 +1261,9 @@ int init_sb_info(struct f2fs_sb_info *sbi)
 			if (get_device_info(i))
 				ASSERT(0);
 		} else if (c.func != INJECT) {
-			if (strcmp((char *)sb->devs[i].path,
-					(char *)c.devices[i].path)) {
+			if (strncmp((char *)sb->devs[i].path,
+					(char *)c.devices[i].path,
+					MAX_PATH_LEN)) {
 				MSG(0, "paths mismatch: %s, %s\n",
 					(char *)sb->devs[i].path,
 					(char *)c.devices[i].path);
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
