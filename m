Return-Path: <SRS0=yNny=5L=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5CDC2BA15
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 26 Mar 2020 03:08:37 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CE0720719;
	Thu, 26 Mar 2020 03:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="DPdoVMNV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="W00p2TZV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="hqrnG15g";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="X3USqXR4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE0720719
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:References:Mime-Version:Message-Id:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=epiE6F+mVwUW2Orakd0T9OUrKYQ4SpIgi/yqQVb78os=; b=DPdoVMNVhJD1p7wa9QsTt3gN7
	Uaeaa0ms/tSY6qmJLEZG0kbompp8+nPPyNolp1fRIGYBcUgy150eQyViqwF3S3wbAAgfWP6vCAcMM
	WIMlggs+fxWb6HzuvR9cMZ3jzLriQlb3HEQhsQLxu082ppdd4TdH8K6RGpdrtW5T/HsfE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jHIsm-00048a-S8; Thu, 26 Mar 2020 03:08:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <3rBx8XgYKAM8DvEJvE19916z.x97@flex--satyat.bounces.google.com>)
 id 1jHIsl-00048A-Lj
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Mar 2020 03:08:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:References:
 Mime-Version:Message-Id:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5Pqv0B5ke8kbkLCKzahA1ADTWdbJkwiiM3DJVPre+r0=; b=W00p2TZVzoWDjE91/YHaQ0gfO
 vLuA+O+cOdmYNnxwRHUlUkV1oHMzAt+4U66K1dUe2owh6pK0gX7F14wl+c3i1xUe7miYDLPZa/S7q
 lWPDQ+IOchaK2E4iZDZjouohB9EMNgRYthnF2SEwohluZwep1CWjvCnNxI/5uWwytFNig=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:References:Mime-Version:Message-Id:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5Pqv0B5ke8kbkLCKzahA1ADTWdbJkwiiM3DJVPre+r0=; b=hqrnG15gKlgKcsSFw0mYUH1f+g
 W4WN7f4TFWgXE5p421MHuZPSr8P84//ZDM9HPobXx8xpQYJOh8D1SvWChvWx99ZavbriOa1HyTG76
 rNzsUJasRt2g3iYtHNoZQXen/S7hQzqSl9tE8CLrlVr4Ekw5m3FJIbYAuDvlOkU4ndhE=;
Received: from mail-pj1-f74.google.com ([209.85.216.74])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jHIsk-007lx0-Hl
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Mar 2020 03:08:35 +0000
Received: by mail-pj1-f74.google.com with SMTP id i3so3238710pjx.8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 25 Mar 2020 20:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=5Pqv0B5ke8kbkLCKzahA1ADTWdbJkwiiM3DJVPre+r0=;
 b=X3USqXR4qL98zoBR5xm+r5Iwa8B7XKg984qzqZUkzeS1r3XKmdcWL9n1SgvI9HghUg
 nM8y2dYeRcEviKJjMBvmdiOP1aLGK4HVl0FuTl7SS5gwdoicJBrE5nU+5T8si6fpwKaL
 Pq2J6FlR6VjJQjL40Ew3CkSMLuaYGSEO+ESNDhAkZjjWKGbWtNCtMOdYNRrN46eBHN6o
 RzVNmzzi9/0AKhFVuWRe+DrZKodOlN8Dsv+LrnR1WFteaMcrajtDGhf/gnb2Ie0WVl1q
 /xPclDdF1ylxfkyQpubwsHb5lYmzOnNcSQrPbfoGClrnii8UPWG7EKZ8yHC4qXoA9hsW
 ASMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=5Pqv0B5ke8kbkLCKzahA1ADTWdbJkwiiM3DJVPre+r0=;
 b=MU4HiNDvL3BrtmqGPkNAJAyLyk6s80G/1IT8HK38CHfAYNSOWnf2zYsYFTbvLUGEHx
 Mz6amEnLh+6X/gL8sOXCUvOTdCv+ImE6g11mavQbVm73/luYYWz545EEVp4TnjvvTPFu
 Zin1SsXDLcl49cLEUk/9pVnSzf8meqXR+M2N6gaQn2QeHYx42Mwuzc/NDE1hzd8WOL++
 jsS1z11Cl9AMGCY8PW3bTQT+eV8/vWC688Sj+PBFjuqaFFJiYuBUXC2Yl/CZE7Inbs27
 DBBJrEm1Q4lg3Hn3+O7v/Vfacmsu/gAKXqIA7FrUXJLdukNrPXn0TMq3rnFKt7ZubRfV
 /Eyg==
X-Gm-Message-State: ANhLgQ2oS4SuKxVaigApDRaX/5PKpUUTwBTN4ibI2c5L5rRU+XT4lZEy
 wFqQKymyIrZE6zEF27KoyOj6BP9vfqc=
X-Google-Smtp-Source: ADFU+vvhE8/SSERvu33TE10DeCwz8+fW0QlS4JPaKhBx2Csq6iMcHH1qpy7Lzsv9wgwCkHL4I3oJP3dAAhY=
X-Received: by 2002:a17:90a:9501:: with SMTP id
 t1mr777236pjo.108.1585192108842; 
 Wed, 25 Mar 2020 20:08:28 -0700 (PDT)
Date: Wed, 25 Mar 2020 20:06:59 -0700
In-Reply-To: <20200326030702.223233-1-satyat@google.com>
Message-Id: <20200326030702.223233-9-satyat@google.com>
Mime-Version: 1.0
References: <20200326030702.223233-1-satyat@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
X-Headers-End: 1jHIsk-007lx0-Hl
Subject: [f2fs-dev] [PATCH v9 08/11] fs: introduce SB_INLINECRYPT
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
Cc: Kuohong Wang <kuohong.wang@mediatek.com>,
 Satya Tangirala <satyat@google.com>,
 Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
 Kim Boojin <boojin.kim@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Introduce SB_INLINECRYPT, which is set by filesystems that wish to use
blk-crypto for file content en/decryption.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 fs/proc_namespace.c | 1 +
 include/linux/fs.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 273ee82d8aa97..8bf195d3bda69 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -49,6 +49,7 @@ static int show_sb_opts(struct seq_file *m, struct super_block *sb)
 		{ SB_DIRSYNC, ",dirsync" },
 		{ SB_MANDLOCK, ",mand" },
 		{ SB_LAZYTIME, ",lazytime" },
+		{ SB_INLINECRYPT, ",inlinecrypt" },
 		{ 0, NULL }
 	};
 	const struct proc_fs_info *fs_infop;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index abedbffe2c9e4..5c758a765923d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1371,6 +1371,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_NODIRATIME	2048	/* Do not update directory access times */
 #define SB_SILENT	32768
 #define SB_POSIXACL	(1<<16)	/* VFS does not apply the umask */
+#define SB_INLINECRYPT	(1<<17)	/* Use blk-crypto for encrypted files */
 #define SB_KERNMOUNT	(1<<22) /* this is a kern_mount call */
 #define SB_I_VERSION	(1<<23) /* Update inode I_version field */
 #define SB_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
-- 
2.25.1.696.g5e7596f4ac-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
