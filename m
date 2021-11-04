Return-Path: <SRS0=DfLr=PX=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515DFC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  4 Nov 2021 08:22:29 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0C2960240
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  4 Nov 2021 08:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F0C2960240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1miY0w-0006qW-Fz; Thu, 04 Nov 2021 08:22:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mudongliangabcd@gmail.com>) id 1miY0u-0006qQ-Jo
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Nov 2021 08:22:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CyUgf+E27izz8eZXu5EdO3onvde6cXVaxrtlTel0Gjk=; b=PBLv8mFylgNGaPfV6gs+E5k1DF
 c71HuQY2yOP7kTQX5/upTHKIdSKuDhKCo0dN7svAioZt6xgZbVXCwxl0cDZqjg7OezTXz8njcQTX6
 fMK7nG4j74L0JSs4mthSzBS0GWznJF1dgMqIiNUQB7p07vP3srBDVBybWIUAz6wa8Byk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CyUgf+E27izz8eZXu5EdO3onvde6cXVaxrtlTel0Gjk=; b=R
 488EBlNVZQybFAud+Lj5ov83/A5KIzbP0S0xBYAj0ihOIuhiQNvzrrT8XeHiqYktfsYim5AK9R+qz
 3f2OV2cVdpKGvJbDD0uTzO1kuSd5kTQiyK8Y7lmcanGntUCQjh8oe6kVcpuSFvWsznPcPEqcV4LxT
 2t9CgDhW5M364WAs=;
Received: from mail-pl1-f170.google.com ([209.85.214.170])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.3)
 id 1miY0u-001A8D-2Q
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Nov 2021 08:22:24 +0000
Received: by mail-pl1-f170.google.com with SMTP id t11so5937177plq.11
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 04 Nov 2021 01:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CyUgf+E27izz8eZXu5EdO3onvde6cXVaxrtlTel0Gjk=;
 b=T4HeVGgFFrZdkuI85Bv3La9ebDCcKARia1U8w6+C7sAJH4G3+09PgbpTXs/lka+buB
 OF5J3MhrtOZsgBA2oihZSiHfOBA6gqBVW2+ANchQrjtPDzICz0bnwT0GoYxXn2S3Eei7
 eUlrhQCzE34Dm7ZJJ1b00zu4NLxaYmYoV3t49stkPfwhxvUbcqNBY311qyOYNOFv+Yud
 ljH38voo6ORAJ9v5mZmC+qVhPd5p+wiy4A4THXrZ7Whnm6w8iHMrzPzESRpbhnHxAULb
 ab19THiXMDgDbFks9w4XGqOlum4stt5ChV09IIOL2ZuGJnMWdPPoE9Vnv4XxixfwEsPv
 oG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CyUgf+E27izz8eZXu5EdO3onvde6cXVaxrtlTel0Gjk=;
 b=5hMwl/R8eHOu1B8AE5p5WjiDK2BatjlufqA5/HaG5GnBSOppeJwkc+munT4HRb9iWe
 psqu/UEkkfBGqcTCgrIEXcNv7vx0YmXQyuJbu7r6O5GWSaBTpGv8/AYT9fe7dVtiKSw7
 Gzjffg1cycjz/IjE1OQwGCLJ0vJvfq/1gUIqyHETvURZ/+XuQH3cthROjNHEHRM3xIpK
 iISZjOki3HdU1aP5zL3n33mVoeojTC5Orw6JbNwVI2LW6liSZYc0lrScEjilCSlO7lAN
 qDXcW0DAMLgivpFxaw9cjvLvFolt1/lNjmkJTffCq8IHy/PkrR+BXJIRVqehM94CnYPR
 F4gQ==
X-Gm-Message-State: AOAM531surGMlf3XfO80R2Yvyin0n+qQXnQokFhmTybUSdBMmqH13BsG
 LLGGkzADev+r+yUTE2d8Oec=
X-Google-Smtp-Source: ABdhPJzIGhrUoaVah+gozgNMaDDVh94KHE4PVsAecpIA5T1RBgEXLmZSdPSO6V1LraPH7O2zGbWk4w==
X-Received: by 2002:a17:90b:155:: with SMTP id
 em21mr20866570pjb.12.1636014138415; 
 Thu, 04 Nov 2021 01:22:18 -0700 (PDT)
Received: from localhost.localdomain ([94.177.118.123])
 by smtp.gmail.com with ESMTPSA id m3sm4826985pfk.190.2021.11.04.01.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Nov 2021 01:22:17 -0700 (PDT)
From: Dongliang Mu <mudongliangabcd@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Sahitya Tummala <stummala@codeaurora.org>
Date: Thu,  4 Nov 2021 16:22:01 +0800
Message-Id: <20211104082202.1286551-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Headers-End: 1miY0u-001A8D-2Q
Subject: [f2fs-dev] [PATCH v2] fs: f2fs: fix UAF in
 f2fs_available_free_memory
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
Cc: linux-kernel@vger.kernel.org, Dongliang Mu <mudongliangabcd@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

if2fs_fill_super
-> f2fs_build_segment_manager
   -> create_discard_cmd_control
      -> f2fs_start_discard_thread

It invokes kthread_run to create a thread and run issue_discard_thread.

However, if f2fs_build_node_manager fails, the control flow goes to
free_nm and calls f2fs_destroy_node_manager. This function will free
sbi->nm_info. However, if issue_discard_thread accesses sbi->nm_info
after the deallocation, but before the f2fs_stop_discard_thread, it will
cause UAF(Use-after-free).

-> f2fs_destroy_segment_manager
   -> destroy_discard_cmd_control
      -> f2fs_stop_discard_thread

Fix this by stopping discard thread before f2fs_destroy_node_manager.

Note that, the commit d6d2b491a82e1 introduces the call of
f2fs_available_free_memory into issue_discard_thread.

Fixes: d6d2b491a82e ("f2fs: allow to change discard policy based on cached discard cmds")
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 fs/f2fs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 78ebc306ee2b..dbe040b66802 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4352,6 +4352,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 free_stats:
 	f2fs_destroy_stats(sbi);
 free_nm:
+	/* stop discard thread before destroying node manager */
+	f2fs_stop_discard_thread(sbi);
 	f2fs_destroy_node_manager(sbi);
 free_sm:
 	f2fs_destroy_segment_manager(sbi);
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
