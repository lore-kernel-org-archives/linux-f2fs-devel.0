Return-Path: <SRS0=nHTy=AG=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449D3C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:40:46 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09635206BE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="ev/oz79R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Xj4YLF5h";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="JL/rqMEt";
	dkim=neutral (0-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="sXJDwku6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09635206BE
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-Id:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KG6tE0/FRuHvCR3UJjH7eb6PgxBbso8B+LHUYeCWOUs=; b=ev/oz79RZORQONxgPOHC/oEapf
	9+Kzpg3RUn9mH8f90TcHyGCfEiYu8qtufQAjwCjZkejuzUS0cfPtoyX8rhf+2rh/y3b7901aARm4O
	qcegK1wihZXH9U21rMCD4fg7XXwsmgQDiz7M91Gex+Mv9/KhLRB5jix6MbQMLNElx7wM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1joRBL-0007CT-HF; Thu, 25 Jun 2020 12:40:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <fishland@aliyun.com>) id 1joRBJ-0007CG-U2
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Jun 2020 12:40:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OrUK9NlrDcqjCu5GwHoEIoauj09eZSsplfxNdAoL6+o=; b=Xj4YLF5hNPkQxMkfAbJwPF5I1o
 p1fzgqERd42u64owCQ+gwHXNW8JfM2FGS445R2ZthrvATZA45qtRfZHk8epIxdGFeKWZoVa3DSAP8
 jLjhnaFTLZFPut8nkeqb1xxGBalpY4fnaCRk/ulmoH2uCBgTZpeDX074onkuvwZTV8IU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=OrUK9NlrDcqjCu5GwHoEIoauj09eZSsplfxNdAoL6+o=; b=J
 L/rqMEtXE/qseydm3bzHYKB2Elv/jH9OlRrZ2JfyJpcV2mZGuQ3iMBgIkUNxhp2hMUqHbv1fAeV39
 1LxB9V7DAU7qCDdDITaWwVBmHamOGPAHoPPkne4LdMyT+El1dT3f0vne+8ypS8hu4DLrUznffslXF
 9Rs4qOesXlkPEHDM=;
Received: from out30-28.freemail.mail.aliyun.com ([115.124.30.28])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1joRBH-000Vqt-Bh
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Jun 2020 12:40:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1593088819; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=OrUK9NlrDcqjCu5GwHoEIoauj09eZSsplfxNdAoL6+o=;
 b=sXJDwku6JJSnoTMc8N0uS6FVkcuiSk5C1oRNzc/56SOsK5VuhvpVtJ/Yl0jM84xMSn2g/CaOduGtwdd5FSsqMq5ENm2Dsv1GuaDQOCsqx/4IbnjqmPpvRKIVrE5ETZ46St4MbSYFqORkVUB0GVLkETk7+OUeJ1b8tDQB59VBh1w=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1650266|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0132381-0.000659421-0.986103;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e01422; MF=fishland@aliyun.com; NM=1; PH=DS; RN=5;
 RT=5; SR=0; TI=SMTPD_---0U0ggW-2_1593088813; 
Received: from localhost.localdomain(mailfrom:fishland@aliyun.com
 fp:SMTPD_---0U0ggW-2_1593088813) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 25 Jun 2020 20:40:19 +0800
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Thu, 25 Jun 2020 20:40:11 +0800
Message-Id: <20200625124011.8072-1-fishland@aliyun.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Headers-End: 1joRBH-000Vqt-Bh
Subject: [f2fs-dev] [PATCH] f2fs: fix typo in comment of f2fs_do_add_link
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
From: Liu Song via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Liu Song <fishland@aliyun.com>
Cc: Liu Song <fishland@aliyun.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

stakable/stackable

Signed-off-by: Liu Song <fishland@aliyun.com>
---
 fs/f2fs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index d35976785e8c..069f498af1e3 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -779,7 +779,7 @@ int f2fs_do_add_link(struct inode *dir, const struct qstr *name,
 		return err;
 
 	/*
-	 * An immature stakable filesystem shows a race condition between lookup
+	 * An immature stackable filesystem shows a race condition between lookup
 	 * and create. If we have same task when doing lookup and create, it's
 	 * definitely fine as expected by VFS normally. Otherwise, let's just
 	 * verify on-disk dentry one more time, which guarantees filesystem
-- 
2.20.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
