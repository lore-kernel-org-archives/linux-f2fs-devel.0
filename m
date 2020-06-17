Return-Path: <SRS0=Iz0M=76=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7564BC433E3
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:57:48 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40AE121475;
	Wed, 17 Jun 2020 07:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="Eos2eL4s";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="NpsawCrR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="lEhCSy8T";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="TluV8U8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40AE121475
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:References:Mime-Version:Message-Id:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Lh7wGkkxlWJXD9B5j5lOuS/deHEzW85KNM9LcKT0rmk=; b=Eos2eL4smYV61PiGpKvbCAbsL
	cfouTSXH4Joc++NTnGIgrZXbTR4YaSBgaR8JjI7fH3oZMVSBN7RFnmJXoEC9m4fpDPYJgBpowate4
	PSyLNc//ULaLVNubKcq0sEo1lWelkDyDLxifY707//2zl4uqw7kl0zZlTX/Tu2PqMofNU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jlSx8-0002Fq-S2; Wed, 17 Jun 2020 07:57:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <38szpXgYKADEfNglNgTbbTYR.PbZ@flex--satyat.bounces.google.com>)
 id 1jlSx7-0002Fj-Fc
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Jun 2020 07:57:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:References:
 Mime-Version:Message-Id:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G/fPjNKj6PNXBhhglcGDXFh+C2RJTmo0o/rYX7Lpb+0=; b=NpsawCrRcFfpZ4A9W7jkTtR3c
 hxCnWw0qXJMFeKFgkaM6htoZGeMTBsmGe44LRq3eho8ZOPDbU9Y6to4jWKHyrxB9orwAdQnpk4dc9
 vwC4/0A974PysbQzUaL0FODMAjPlOnImrgM2QO0m0kuOJhHovFjCT0sUB3I6QrJF04AVQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:References:Mime-Version:Message-Id:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=G/fPjNKj6PNXBhhglcGDXFh+C2RJTmo0o/rYX7Lpb+0=; b=lEhCSy8TjT4Hi0ydU5htneIdyi
 X79D3lDe2GvXcQTP8D8ZFfZlUQVJ3bCU1IQSP2p55jeHEF+wVB5nA/gTljpdua5mK2yr0aGz6Jtu7
 62XldtROAkWXFCtQv5JvH0kV0QF3vkBgmA8Qu4Bm1DIMXrbuP4rmZdWDYmrLBu+Gj2Xc=;
Received: from mail-yb1-f201.google.com ([209.85.219.201])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jlSx6-0094Ad-BB
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Jun 2020 07:57:45 +0000
Received: by mail-yb1-f201.google.com with SMTP id c3so1646901ybp.8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 17 Jun 2020 00:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=G/fPjNKj6PNXBhhglcGDXFh+C2RJTmo0o/rYX7Lpb+0=;
 b=TluV8U8p4btHvRnG6E6rAe71kNH+BvrrGlEUayjO0HSPyFC+sXTxG1hYdqjhQRPKUY
 YDfNaP8YEbdwvHiu0XmRd3SNZSVbMyEDvebwv262dL8uHXfSd2dHrP2ZMHzf8smMGyf8
 aZSebf2M/SqHt4cF4SJ2tKEQvOlqkH606abeCiH0hh2KPEqZG0VysoQXAisisVGnR9hy
 CcDI6rzrx6tGcujgcyBKLSyDzqFCaSEA7l41SnukYRgykKsAYwIMcZDIQe5M8U1Mej2F
 vIl2mlIUiX9vxJe0t0YzmIQiOqjs+8O58+gZVqrIu/vEFjVjpOI9UWCeLB1Jn4CMO8zf
 luQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=G/fPjNKj6PNXBhhglcGDXFh+C2RJTmo0o/rYX7Lpb+0=;
 b=I2NIZ+0NrmcdMvaquHSmRDUJCYzExRSTMRInt8QFQlJKMhECPiBznxHjj6jlHZFCQX
 eMn9+2XD1SoetEKy3SA/i+aDd9Vr1W0PGorZzE0tLkd9+1Mm9c+vmTfNDS5f/zSFQY1E
 K6YY+BhY8R6I2QB7nqPQrsa4IBnizk1vYsbvsT/av+bIcIHrVVAxh0KS9KFyz0XalGLI
 GK5NYPpytAmw2Wk9x9L/nIETmnncnRVULWQVzH3cq0I/T3L5f3Tpd5/hcRfIPA9cmDML
 F+PkE7PEUWjISevZENXubIePIS0EUbyHyCQ2xEtR5UrVC4O7D0AA2A7nxtK8SbUOYPOK
 u2AQ==
X-Gm-Message-State: AOAM53322/Jo+uO2STyl2XSxU2loC8Z+D73BeBmMPxX4+UrwpiJGYYoX
 RRkLlbdDxzcNtdaz0kp2wmGHJ0AOmAY=
X-Google-Smtp-Source: ABdhPJywj8c0Uv6bj9+yC8+EAxU6RuQUxCW39QAO7pvXRpbIsrAXbcARnKWZPdo9CiZyYjT2VpEZFOaFlOA=
X-Received: by 2002:a25:2f4b:: with SMTP id v72mr10935088ybv.232.1592380658499; 
 Wed, 17 Jun 2020 00:57:38 -0700 (PDT)
Date: Wed, 17 Jun 2020 07:57:29 +0000
In-Reply-To: <20200617075732.213198-1-satyat@google.com>
Message-Id: <20200617075732.213198-2-satyat@google.com>
Mime-Version: 1.0
References: <20200617075732.213198-1-satyat@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
To: linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
X-Headers-End: 1jlSx6-0094Ad-BB
Subject: [f2fs-dev] [PATCH 1/4] fs: introduce SB_INLINECRYPT
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
From: Satya Tangirala via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Satya Tangirala <satyat@google.com>
Cc: Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Introduce SB_INLINECRYPT, which is set by filesystems that wish to use
blk-crypto for file content en/decryption. This flag maps to the
'-o inlinecrypt' mount option which multiple filesystems will implement,
and code in fs/crypto/ needs to be able to check for this mount option
in a filesystem-independent way.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 fs/proc_namespace.c | 1 +
 include/linux/fs.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 3059a9394c2d..e0ff1f6ac8f1 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -49,6 +49,7 @@ static int show_sb_opts(struct seq_file *m, struct super_block *sb)
 		{ SB_DIRSYNC, ",dirsync" },
 		{ SB_MANDLOCK, ",mand" },
 		{ SB_LAZYTIME, ",lazytime" },
+		{ SB_INLINECRYPT, ",inlinecrypt" },
 		{ 0, NULL }
 	};
 	const struct proc_fs_opts *fs_infop;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6c4ab4dc1cd7..abef6aa95524 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1380,6 +1380,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_NODIRATIME	2048	/* Do not update directory access times */
 #define SB_SILENT	32768
 #define SB_POSIXACL	(1<<16)	/* VFS does not apply the umask */
+#define SB_INLINECRYPT	(1<<17)	/* Use blk-crypto for encrypted files */
 #define SB_KERNMOUNT	(1<<22) /* this is a kern_mount call */
 #define SB_I_VERSION	(1<<23) /* Update inode I_version field */
 #define SB_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
-- 
2.27.0.290.gba653c62da-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
