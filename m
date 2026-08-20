Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573EDC5DF81
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XzLIxOPBJJ7oUsscBLq7camDxhypLts/C4ry5oHdNC0=; b=jyUH1CQOSjXRKXJlBbFtoy1V7c
	qPN/HTdScsU7glK7Lt5e1cnkI0Lk83XPx2DJdrhW3mAZywqOKKNzL8s7hTCO9S/xqyoKmsUPciBup
	PxojqR3P3xLishD8Vy9Bp4ByjKEtznPGzjZ2p/DTToKhDvh12cvs9xZUGJQeOnl/GBOI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wx5rz-0001np-SN;
	Thu, 20 Aug 2026 16:44:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wx5rr-0001nb-MD
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 16:43:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RFM8Ikwybwd2rTJ1nTIy8PeNwMoT60bA78u9TlckWQI=; b=dDDz8kisIPYgkVvyzMOfNvYKjm
 eQj/sBpkNdb5D9wCtikEcW7C+xV7eRmnI3lf1jL9IuYy+swotPmO2SyJ9wXloXjl1+1qhdWzn1mtr
 05idbl1Qu3WjwA2nYRi8FgTlXF0gkuVVQPWnNzRyrZQUZVfwIpzX0+S4WY40Tauhs7+k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=RFM8Ikwybwd2rTJ1nTIy8PeNwMoT60bA78u9TlckWQI=; b=f
 vbuZomFJNwcw97B0Jd2fjyt/TStNGnEWWPATF21Pt+xKyGA3Gr8znF0UKstrU8GM7U7j+VXm7SGu6
 IjheGf+7/IBqgiYKD/jfaFkKwWLkWX49/sKt67ieDSoYDLJDaLfZYlcAy7YjRUYReg/bg9BNCaxy5
 uHFgx3aHhHSQB6QI=;
Received: from mail-pg1-f182.google.com ([209.85.215.182])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wx5rq-0003XV-RY for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 16:43:52 +0000
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-cc11a30a259so103500a12.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 09:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787244224; x=1787849024; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RFM8Ikwybwd2rTJ1nTIy8PeNwMoT60bA78u9TlckWQI=;
 b=A+5T54ifzg9GAUlWCirYr2p2q6+605P23xJGEoPth5FQlfoe0vT7T6zN5NU8mAq97n
 ocpFXg+iJouo6OVU8SEkTYeeAz2flxV8WQVWjg0kCIwvUMbJ+hQW3TqMZz8ff+ZLkGCF
 Jy4KATFTmhClPUuDJNRo/qqW4+NDpXnWWMqy7neHeFDzeDk0efPY0D4Zh9IierN5Au/6
 K+EtpWyc52AxnN34JiCIy2qh+0lUvZbReyAiThgkFlpPl20YXXRoGO61JkZ+PW9hKjK2
 6bF1RnBLZqL8Hc+j5jLAm/9OW2Ie/NQpyElAmXHiYPVuGPId07TE4NR/mydBb6VsRzvA
 vigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244224; x=1787849024;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RFM8Ikwybwd2rTJ1nTIy8PeNwMoT60bA78u9TlckWQI=;
 b=gpf29y52NKH5LX5V8NbK8G0bCc5RlTWd3H0Tn2L/Hl5lvV5tC7QN9Nxjj2zlTZHmgO
 erEkK9mfKtrC8+PJXeUuLqFppqXv450W47GZsP7Gq4rmqeHo0ziEmGiSUSOKODFTgbsS
 /K93SKOjS9vrCUgqHgC9vRvi8UAJGhcYSh+ezQTyhHVCTEw7lo7QfNdNmg3PIaKEgSB0
 EOSyD44pw+ApO6ARawKsdiKOmvlEa5j+l97D23FCyr6oeA9YVbU21HMPQSHB/gtXKEkQ
 9/kjb9QlHi6PlnNU3JsGqWH8J4+uYwTwQ0oL5gAgLvvxovbX6gYfI4wzuFgny0gqAwlf
 wkXA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrt9gkFpAyfqu7IfgO7wk6Gea9SBzEPkfKPfXUohSsjEEKZ+czWLiqHixmVfeiR1ffQuvWerOnsM1gfGjpW4Fqh@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzS/kwdFJ1u9sWWVG8NGd7xOvE2VJ44pviL+Ar+phDKGzf9i6bm
 Ror05NhrAM+O3NKXmznE7EIuCMuIZ+DNe0incZkXEdoSin+EtSzF5PHF
X-Gm-Gg: AR+sD13po649KX4xWidXpB6Y64Dn4S2bjheLRQwUxtlYFaq90emgQNA+6pIx4+Qe9JX
 /1Yi5FYRWIamG6zPPf8GnUFDv54jPcd2KMmRWKAl+ufRSQ9EhwWwl8kjJmypw2GpJpTYstfWh37
 nT/tqmQCRmuqP3cuEg/MU0zXwixh3pIyMK9HOYROod+CBaWwS4/VBZjq2YWxhPTxpy9qqQV0z74
 ft1OFyUClB2mvm2FzbWrmiWLa2GSqKRy0sjjIxmw3k/zYb1pIbENq/B+mLQkPi/Vn2w6bkArBfj
 OMq8ikENG1+YCgfowiOxbZVR5Qi0dQNDDY8WQdOutwklDfTVbrzt8K3MdKgCl5q9M8U++jI9rYT
 AbL7ubMVar9MgpGdMOaC4lKm0tN6STGZaiBzaMS104e5UiaXKlrkwznHHr9y+Bfa8BiFmlh48Zn
 i55qrFHyEEkKVgkNTyC3UNgPb1b6ul6LzvK2hAIOPTXnCZ1ccJYzEa3weXleUj1VdhcMfxAHIbD
 BrIbCXWmCUJZxeV67KpRWgovQ5u0tepkAOjTkDMPJtdFKtyiFNvWiEWCYzX194kxfzI7qzavpGc
 DL5tq/0Hwj+c
X-Received: by 2002:a05:6a21:6b0f:b0:3c3:8c91:5da0 with SMTP id
 adf61e73a8af0-3cd012342ecmr27718050637.15.1787244224374; 
 Thu, 20 Aug 2026 09:43:44 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e7c:8:9456:9545:1ce8:7c65])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef77bfcsm16485695eec.9.2026.08.20.09.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:43:43 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Thu, 20 Aug 2026 09:43:40 -0700
Message-ID: <20260820164340.2802152-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.737.g08866a6d13-goog
MIME-Version: 1.0
X-Headers-End: 1wx5rq-0003XV-RY
Subject: [f2fs-dev] [PATCH v2] f2fs: avoid setting SBI_NEED_FSCK on
 transient resize failure
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

When free_segment_range() fails in f2fs_resize_fs(), no on-disk
superblock or filesystem metadata has been modified yet, and
free_segment_range() safely restores all in-memory counters before
returning.

However, the current error recovery path unconditionally sets the
SBI_NEED_FSCK flag and prints a scary error message on any error,
forcing an unnecessary and time-consuming fsck.f2fs repair on the
subsequent mount/reboot.

Fix this by separating the error recovery path with a dedicated
recover_user_blocks label to bypass setting SBI_NEED_FSCK on
free_segment_range() failures.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
---
v2: separate error recovery path to bypass SBI_NEED_FSCK on
    free_segment_range() failure and add f2fs_bug_on() in recover_out.
---
 fs/f2fs/gc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index c4da2f31805b..3215630c353d 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2440,7 +2440,7 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 	set_sbi_flag(sbi, SBI_IS_RESIZEFS);
 	err = free_segment_range(sbi, secs, false);
 	if (err)
-		goto recover_out;
+		goto recover_user_blocks;
 
 	update_sb_metadata(sbi, -secs);
 
@@ -2462,11 +2462,14 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 		f2fs_commit_super(sbi, false);
 	}
 recover_out:
-	clear_sbi_flag(sbi, SBI_IS_RESIZEFS);
 	if (err) {
+		f2fs_bug_on(sbi, err == -EAGAIN);
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_err(sbi, "resize_fs failed, should run fsck to repair!");
-
+	}
+recover_user_blocks:
+	clear_sbi_flag(sbi, SBI_IS_RESIZEFS);
+	if (err) {
 		spin_lock(&sbi->stat_lock);
 		sbi->user_block_count += shrunk_blocks;
 		spin_unlock(&sbi->stat_lock);
-- 
2.55.0.737.g08866a6d13-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
