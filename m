Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68AFFC79F99
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  8 Sep 2026 03:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gtszExuC1NR4CThPXSYzawwJ/arpYwzk/nNF7n3ZHQc=; b=bOY7AJ/HZfY4cRAfwltQIOis9T
	TW7otLYy8wOOqhI1SwnQSN86z6ZJQqIKVZV8HtL3jEe7cDiUa7JWwhafqpZPBS1xTcXiRerYUcc7p
	7PRQi3pF84tFFnu3mMbbfUX/trcW2UDKF6kIWwwGPdOlDR1L1TVzl2IAY3bynmNa7bm0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3mnD-0005Cl-2k;
	Tue, 08 Sep 2026 03:46:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jnhuang95@gmail.com>) id 1x3mnB-0005Ce-Op
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 03:46:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V/tREbVz6WBPH5s5Ljt+Dg7/QxlQoVwLYGCAuo+tfHU=; b=Q6ImZLlrEmV92atXPPWhCDIlwz
 6Q5+9l90gkO9IjB/0Fq40mxlksM5AykAiJdxOXzzxnYELACwxuTmi0BsvsRzEhRkmsMffGZY6cF3j
 NlMId8c59w8oQuFNdXe14MmJZp+6OivMFeYFJFmB5y9USOuUcehDcreeg1Ni+W3scCOA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=V/tREbVz6WBPH5s5Ljt+Dg7/QxlQoVwLYGCAuo+tfHU=; b=Q
 jq+1hcxD4RR7Ijc8jJg7A1aexy97oJT7sGIXCzRdqU9/vzQ9OMAKpevj/mT73P6A7xYuZen+cdruG
 BK3JNhayyDxkpZBnVisVNCvTRwGmIzBh8cvYKB0FfgheGuFw9UvRPtnyiQoAdlQddyFUTg/ubGspi
 9lU/5DKZi0wWDYJc=;
Received: from mail-pg1-f182.google.com ([209.85.215.182])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3mnC-00042c-3k for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 03:46:42 +0000
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso3435574a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 20:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788839196; x=1789443996; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=V/tREbVz6WBPH5s5Ljt+Dg7/QxlQoVwLYGCAuo+tfHU=;
 b=YTdvbXztkiwN82cTqLQnWTP9kes5gc92y9jLGgpvWOJIqFUq6sFXr0JfnaykVmhs2U
 sH2yZQ4YgauaYohCWXEZwHsElU/0RR150+o7dAH1tL1ohkG7Kn5xV1uTBdy2NGEkWHWM
 FtrV+ooi8y2pCDn9jCi9uK5mMCWdEfqPgqYggi3Bfv43jg1StE+FfnR7f2JLl5fv0q3F
 CHM8hessmh4VswHAIsYW6gbg4jftRcY2sXCoS3DHEHtkvqWtgSUmuHmKFxhlvsvgYK9X
 A5/zxasFmBLcaNOIk5DZjxD1EfTeutbG5aa/a6Z2YJhfbRgyZrh2/jFFzEGu6jWC+qVZ
 VPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788839196; x=1789443996;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V/tREbVz6WBPH5s5Ljt+Dg7/QxlQoVwLYGCAuo+tfHU=;
 b=TqNwU4DEy3EQdfkxXNUPAv7DitRU93iTsPoLC+iefHxc8KlJwqMX552wX5StGRa4ii
 ad1b6aKuuuT+ktpp5LAZMsPxYoZj+tZcIfXMGiskFcSmW0gmHMhjRt+V8g0Ffp2nbqwE
 h89D1+jqP4eWYDU9hcKi3XOmeyfQfkeya7aguaxwKyMYgrxZ/xbKQFrPywBylK+g0Gk3
 dDhar/grltjf1LdgVKJn2kdQb3kPMn/DcPWq0DacmI9fih0/k8wuID9B0dV68E27gDRZ
 3xpM29yEZptM1EZ+7Q1g27Fz8E6YRFY/9z+NTfuYsrIg/BWFnaeRPIKaffudHdLevi7x
 +0Sg==
X-Gm-Message-State: AFuF++n/N2ad/NgpcdcI8EVaYJMq/Gjo39glbDN3NEDN8cfT9+xP30+b
 zylEqye5MI2UUTTOeMg2eJRRDP3M7qVMz3V8pH1PMelyheTmP/cimNHcGqwJdBb6Z2Q=
X-Gm-Gg: AYBFou3kNL616I4ULELpUVgpwRP1rTqSvc+ar0zjtzCo/W1gSUj3odPdc49Hq6xUAuM
 wAL5olinwQB1I/N3aIHNqih9JmrZKCUuyMQ0rQ9gCfUpTgWb9+w+pdsBb4n4RaEPbLVB4nr1STG
 ZjfKYIcBfuXc0qTylkyQIY+fTkXvOkYKH4mxVcyWFw3KZXJDmc7i7JkFudRJ1jkNWxW3MOUsNQV
 adOKLK2BDy1J4GgD1YWz/J637Pmm8Ihc4gYzRR/TpPBSLpt4dEESldWgp60UwUeTIBuHMlJdrQc
 XEOSe0m7q4kUuAhkeOQ92Lk5w8hmneM1GeVekLLKF0bLKcCJssbodTbzKF4iUSii+B074Yf3oBp
 YeCfaCMFWhN+6hzHRkFTbtrdL98DxLFqX0MBfvejnwvvUordt9TQ/LFcWZyblYZsDjZLS/PUpti
 rSfmgV1mlpVu5cEpuGnXPJluWHqmhu0QxksnojQCAA2tOJJh8R8oJNifIZ60bBdPF+yi+oiqQ6i
 nI9X0iIK4784lfFREKlDHpPslS/5aAglkjshA==
X-Received: by 2002:a05:6a21:1b85:b0:3d3:aed2:6f25 with SMTP id
 adf61e73a8af0-3da216513eamr31644625637.25.1788839196336; 
 Mon, 07 Sep 2026 20:46:36 -0700 (PDT)
Received: from 4ce604c9y2.bytedance.net ([61.213.176.58])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc4643936d0sm3665213a12.1.2026.09.07.20.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 20:46:35 -0700 (PDT)
From: Jianan Huang <jnhuang95@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, chao@kernel.org, jaegeuk@kernel.org
Date: Tue,  8 Sep 2026 11:46:30 +0800
Message-ID: <20260908034630.615415-1-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1x3mnC-00042c-3k
Subject: [f2fs-dev] [PATCH] f2fs: quota: fix stale lock holder on remount
 failure
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
Cc: Jianan Huang <jnhuang95@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

F2FS remount can fail while duplicating a journalled quota file name.

f2fs_remount()
- sbi->umount_lock_holder = current
- kstrdup(F2FS_OPTION(sbi).s_qf_names[i])
  : fails
- free previously duplicated names
- return -ENOMEM

The direct return leaves umount_lock_holder pointing at the failed
remount context.  A later checkpoint may then wrongly treat another
context as the s_umount lock holder.

Clear umount_lock_holder before returning -ENOMEM.

Fixes: eb85c2410d6f ("f2fs: quota: fix to avoid warning in dquot_writeback_dquots()")
Signed-off-by: Jianan Huang <jnhuang95@gmail.com>
---
 fs/f2fs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1314b6ccced9..e249ea19beaf 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2864,6 +2864,7 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 			if (!org_mount_opt.s_qf_names[i]) {
 				for (j = 0; j < i; j++)
 					kfree(org_mount_opt.s_qf_names[j]);
+				sbi->umount_lock_holder = NULL;
 				return -ENOMEM;
 			}
 		} else {
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
