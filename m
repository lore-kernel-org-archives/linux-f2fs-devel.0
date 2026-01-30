Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838DFE6BF3C
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 31 Jan 2026 02:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U0waOgvAzQ58UWgdMHpVidS4yFid1s5uLS9RFmMO0wo=; b=Q0/DUcT1HjX8Y+MbzQqL0pKWDP
	G3GrHA3aTp9fVZ9/++LoUHJ+Ubrph5LF6th0tC1NBQjdds1tP3YqMPWQffT8O8vYXTMhNhpMeavsK
	P7i9wI5OJhPG3GEh91V2zIvUh/AkQCxyB2UnDycQNmSZciZK4DANaqAa4x5urzdhZKL4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vm0hC-000400-F8;
	Sat, 31 Jan 2026 02:26:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1vm0hA-0003zs-U8
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 31 Jan 2026 02:26:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JD/j3IAsEN9OrTXspeUwjpa2tAgt7stPdS0BripLqUI=; b=PcROUUAnkVLjD8/7nfmmOERoUP
 eOX7Nk9cdwt51pBKY3ZLc7EDEu9gnA8JEkIlPhThXRMOOidfXu5A0sGF2CLDZjU83Sfshy5Dsnrs0
 sbDc0zkkdcT60YKCYh3JMJpkos9AMcwczKiMMr98LHNnkBdG56PxWCVUI0oVXFOExVqI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JD/j3IAsEN9OrTXspeUwjpa2tAgt7stPdS0BripLqUI=; b=H1MUr3464QZFnhggnJ/VcvAegW
 DgDQahjBsfdvUG6BKbVN7U1jT9um2UBJRxqcTXvC4fRBoeQIAmq2B35Up8JAwPwAtkR9CCcVBE5HN
 ULBb5kgAig+otnWx03GtYeoVrEE8w+uF5sJDfhAuGG65HbfJOLtBc5ZVW2uIzwG2Cxt0=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vm0hA-0001ti-9w for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 31 Jan 2026 02:26:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 22B5660008
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 31 Jan 2026 02:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE767C116D0;
 Sat, 31 Jan 2026 02:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769826392;
 bh=sVoBYWt86eN4DNlfx895Vh0r1E93SiOa1EZHZwaUzgo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=E7OmvTuPI4a9DiB+hdLXzS39PHbq+2fLhbm1C/n7b+XZCBGvAHDtxJeNh5PYiuzZE
 bzyJ17vHiFXcVSWH/fcOMvzp4J4BjZVm3eeiqI9zqsh8uC5rL0DVaZ2yRoMSkPrrP0
 fHvAONmd7kdJFqUgcB9JgevkPCBXatxGHiQV06eHKYZSYT6qAAFJgrgebOE7qcfbfj
 ihl4NDUvHcJayNXnO8n1joRyJK/X0e0vj7Ja++DrTCv2GhntW15UxesmWfab4LBjRj
 sQ5IHE2ex5bXs2VvORXEa+1tyW1yJiPTPQoNP5cPf2IVc9ZdwILOAAoLP939b40An9
 +ehtfasEYAvKQ==
To: jaegeuk@kernel.org
Date: Fri, 30 Jan 2026 21:28:09 +0800
Message-Id: <20260130132809.59707-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20260130132809.59707-1-chao@kernel.org>
References: <20260130132809.59707-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1vm0hA-0001ti-9w
Subject: [f2fs-dev] [PATCH 2/2] f2fs: introduce trace_f2fs_priority_update
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This patch introduces two new tracepoints for debug purpose.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/checkpoint.c        | 17 +++++++----
 include/trace/events/f2fs.h | 57 +++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 2f5a03e29d0b..4afa5d9a19fc 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -130,9 +130,13 @@ static void uplift_priority(struct f2fs_rwsem *sem, struct f2fs_lock_context *lc
 		return;
 	set_user_nice(current, lc->new_nice);
 	lc->need_restore = true;
+
+	trace_f2fs_priority_uplift(sem->sbi, sem->name, is_write, current,
+		NICE_TO_PRIO(lc->orig_nice), NICE_TO_PRIO(lc->new_nice));
 }
 
-static void restore_priority(struct f2fs_lock_context *lc)
+static void restore_priority(struct f2fs_rwsem *sem, struct f2fs_lock_context *lc,
+						bool is_write)
 {
 	if (!lc->need_restore)
 		return;
@@ -140,6 +144,9 @@ static void restore_priority(struct f2fs_lock_context *lc)
 	if (task_nice(current) != lc->new_nice)
 		return;
 	set_user_nice(current, lc->orig_nice);
+
+	trace_f2fs_priority_restore(sem->sbi, sem->name, is_write, current,
+		NICE_TO_PRIO(lc->orig_nice), NICE_TO_PRIO(lc->new_nice));
 }
 
 void f2fs_down_read_trace(struct f2fs_rwsem *sem, struct f2fs_lock_context *lc)
@@ -153,7 +160,7 @@ int f2fs_down_read_trylock_trace(struct f2fs_rwsem *sem, struct f2fs_lock_contex
 {
 	uplift_priority(sem, lc, false);
 	if (!f2fs_down_read_trylock(sem)) {
-		restore_priority(lc);
+		restore_priority(sem, lc, false);
 		return 0;
 	}
 	trace_lock_elapsed_time_start(sem, lc);
@@ -163,7 +170,7 @@ int f2fs_down_read_trylock_trace(struct f2fs_rwsem *sem, struct f2fs_lock_contex
 void f2fs_up_read_trace(struct f2fs_rwsem *sem, struct f2fs_lock_context *lc)
 {
 	f2fs_up_read(sem);
-	restore_priority(lc);
+	restore_priority(sem, lc, false);
 	trace_lock_elapsed_time_end(sem, lc, false);
 }
 
@@ -178,7 +185,7 @@ int f2fs_down_write_trylock_trace(struct f2fs_rwsem *sem, struct f2fs_lock_conte
 {
 	uplift_priority(sem, lc, true);
 	if (!f2fs_down_write_trylock(sem)) {
-		restore_priority(lc);
+		restore_priority(sem, lc, true);
 		return 0;
 	}
 	trace_lock_elapsed_time_start(sem, lc);
@@ -188,7 +195,7 @@ int f2fs_down_write_trylock_trace(struct f2fs_rwsem *sem, struct f2fs_lock_conte
 void f2fs_up_write_trace(struct f2fs_rwsem *sem, struct f2fs_lock_context *lc)
 {
 	f2fs_up_write(sem);
-	restore_priority(lc);
+	restore_priority(sem, lc, true);
 	trace_lock_elapsed_time_end(sem, lc, true);
 }
 
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index c3b6b509472f..9364e6775562 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -2525,6 +2525,63 @@ TRACE_EVENT(f2fs_lock_elapsed_time,
 		__entry->other_time)
 );
 
+DECLARE_EVENT_CLASS(f2fs_priority_update,
+
+	TP_PROTO(struct f2fs_sb_info *sbi, enum f2fs_lock_name lock_name,
+		bool is_write, struct task_struct *p, int orig_prio,
+		int new_prio),
+
+	TP_ARGS(sbi, lock_name, is_write, p, orig_prio, new_prio),
+
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__array(char, comm, TASK_COMM_LEN)
+		__field(pid_t, pid)
+		__field(unsigned int, lock_name)
+		__field(bool, is_write)
+		__field(int, orig_prio)
+		__field(int, new_prio)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= sbi->sb->s_dev;
+		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
+		__entry->pid		= p->pid;
+		__entry->lock_name	= lock_name;
+		__entry->is_write	= is_write;
+		__entry->orig_prio	= orig_prio;
+		__entry->new_prio	= new_prio;
+	),
+
+	TP_printk("dev = (%d,%d), comm: %s, pid: %d, lock_name: %s, "
+		"lock_type: %s, orig_prio: %d, new_prio: %d",
+		show_dev(__entry->dev),
+		__entry->comm,
+		__entry->pid,
+		show_lock_name(__entry->lock_name),
+		__entry->is_write ? "wlock" : "rlock",
+		__entry->orig_prio,
+		__entry->new_prio)
+);
+
+DEFINE_EVENT(f2fs_priority_update, f2fs_priority_uplift,
+
+	TP_PROTO(struct f2fs_sb_info *sbi, enum f2fs_lock_name lock_name,
+		bool is_write, struct task_struct *p, int orig_prio,
+		int new_prio),
+
+	TP_ARGS(sbi, lock_name, is_write, p, orig_prio, new_prio)
+);
+
+DEFINE_EVENT(f2fs_priority_update, f2fs_priority_restore,
+
+	TP_PROTO(struct f2fs_sb_info *sbi, enum f2fs_lock_name lock_name,
+		bool is_write, struct task_struct *p, int orig_prio,
+		int new_prio),
+
+	TP_ARGS(sbi, lock_name, is_write, p, orig_prio, new_prio)
+);
+
 #endif /* _TRACE_F2FS_H */
 
  /* This part must be outside protection */
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
