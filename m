Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C8EE63F0A
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 15 Feb 2026 17:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nl97C9MUpNtIERkZGViB52CiK8oR43kA5r2TZI5IJfY=; b=M2Rjor3aS/KV4T+6ojwvMVfAg5
	3qD8e8mWK2FkkTKDbw/n/qe1fQH4rUZ54rU3AMkuCAzUGWddynQbtoORelPfp671uoIYm5gRXhtc+
	Bl+b/8QEQ21AvyNkiJKk7FmbKqcAm1bgh46cWBcgvCac18A10nYsEWLceRCcaUYEgJmU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vrg7q-0008BH-TH;
	Sun, 15 Feb 2026 17:41:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashal@kernel.org>) id 1vrg7l-0008Ao-QV
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 15 Feb 2026 17:41:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IIlM100livpqdwZOxQDTe9tTfk0l5JiU89xwYAo1ySs=; b=XynPKBxo9EvZoCC7Ri8dApRcDU
 og4uhur387JxE9KQRJu4dOrLaTi86oWd3PgAMAGM8B9+x/88ejMv0jmgEuoLd5LlcU6vGQkCJ5SHd
 9LeyjeOqT+HYhlYwbqPHbYoXWIDCKPLU+ih0Gy4r/Rj0z3Uwf4++Ict6UAbR/tA2dkUs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IIlM100livpqdwZOxQDTe9tTfk0l5JiU89xwYAo1ySs=; b=BOG3s72QtiiydTjwIps8snCgMA
 dF6m/3rUvUmxYytKxAVK63oBXtriEYJzhIZAuD3NvDDWBau846RqBLM04oSJhPN8F8VrsJVy//41J
 k5tYOthX4HXu2jxGbl2Y7Q4vtDM9VNgtNHrU3rslIoASIKN7KWijbxmCypDR8Dfssp3Q=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vrg7l-0007FN-W1 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 15 Feb 2026 17:41:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 71A4B442F0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 15 Feb 2026 17:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE71FC4CEF7;
 Sun, 15 Feb 2026 17:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771177292;
 bh=nAx3UEsTfVcgjmVMxlSshKW1Gcw3BWPVkzJPmkjSftI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oqTFKDxINPj4is0owGIZMY7rPLiscK6eRDdXUF3geo2BXoj6bnYd3I37h5lGXPVoI
 fczYIwnqQaGOLChlLWey9nSFkkkp+6Qpq8lVRU2pDzVwibWjtyUyQbyQcNHwYCUvGT
 2UeAF7ifKR1Ps21ZrIoZUW8wv7f4Qk2Z2gfsy2g++cCZMvKgRea5x45o+ZVPC5+sg3
 UGnqA5pas5Vc+mAfbAQz1MWlS1ubRllDDdwmdFHF9aN8nUNK/h3ZtwELnPQIvpaelP
 NGOglEahVvwAhyWulXFvrZafft1HNgK8dMIL8vHySQjPGAid9G/yaFWB0nSCu0Zj9M
 ZkhDoa+QZnUcg==
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Date: Sun, 15 Feb 2026 12:41:17 -0500
Message-ID: <20260215174120.2390402-9-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215174120.2390402-1-sashal@kernel.org>
References: <20260215174120.2390402-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
X-Headers-End: 1vrg7l-0007FN-W1
Subject: [f2fs-dev] [PATCH AUTOSEL 6.19-6.18] f2fs: fix to do sanity check
 on node footer in __write_node_folio()
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
From: Sasha Levin via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Sasha Levin <sashal@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

[ Upstream commit 0a736109c9d29de0c26567e42cb99b27861aa8ba ]

Add node footer sanity check during node folio's writeback, if sanity
check fails, let's shutdown filesystem to avoid looping to redirty
and writeback in .writepages.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

So `sanity_check_node_footer` doesn't exist in 6.12.y. The fix would
need more substantial adaptation for older trees, but the core issue
(looping redirty on corrupted footer) still exists there - the old code
uses `f2fs_bug_on` which only triggers a WARN_ON (unless
CONFIG_F2FS_CHECK_FS is set) and then continues processing the corrupted
node.

## Analysis Summary

### What the commit does

The commit replaces `f2fs_bug_on(sbi, folio->index != nid)` in
`__write_node_folio()` with a proper call to
`sanity_check_node_footer()` + `f2fs_handle_critical_error()`.

### The bug

When a node folio has a corrupted footer (nid mismatch or other
inconsistency):

1. **Old behavior**: `f2fs_bug_on()` triggers either a `BUG_ON()`
   (kernel crash with `CONFIG_F2FS_CHECK_FS`) or just `WARN_ON` + sets
   `SBI_NEED_FSCK` and **continues execution**. In the WARN_ON case, the
   corrupted node gets processed and written. But more critically, if
   the node gets redirected to `redirty_out` or encounters another issue
   later, it enters an **infinite loop** of being redirtied and re-
   attempted for writeback in `.writepages`, since nothing stops the
   cycle.

2. **New behavior**: `sanity_check_node_footer()` detects the corruption
   more thoroughly (checking multiple footer fields, not just nid), and
   `f2fs_handle_critical_error()` shuts down the filesystem to **break
   the infinite writeback loop**.

### Why it matters

- **Infinite loop / soft lockup**: Without this fix, a corrupted node
  footer causes the kernel to loop endlessly trying to write the page,
  consuming CPU and potentially hanging the system.
- **Filesystem corruption defense**: On corrupted or fuzzed images, the
  old code would continue operating on inconsistent data.
- **Small, surgical fix**: Only 5 lines changed (1 insertion, 1 deletion
  effectively), replacing an assertion with a proper error handling
  path.

### Dependencies

The fix calls `sanity_check_node_footer()` (introduced in v6.15-rc1 by
commit 1cf6b5670af1f) and `f2fs_handle_critical_error()` +
`STOP_CP_REASON_CORRUPTED_NID`.

Crucially, `sanity_check_node_footer()` was **already backported** to
6.17.y and 6.18.y as part of commit c18ecd99e0c70's backport. Both
`f2fs_handle_critical_error` and `STOP_CP_REASON_CORRUPTED_NID` also
exist in these stable trees.

### Risk assessment

- **Very low risk**: The change replaces a debug assertion with proper
  error handling + filesystem shutdown. The error path (`goto
  redirty_out`) already exists and is well-tested.
- **Applies cleanly** to 6.17.y and 6.18.y (minor context difference
  with `f2fs_down_read` vs `f2fs_down_read_trace` but that's outside the
  hunk).
- For older trees (6.12.y and below), `sanity_check_node_footer()`
  doesn't exist, so a more complex backport would be needed.

## Verification

- **git show 0a736109c9d29**: Confirmed the actual commit is +5/-1
  lines, single file change in fs/f2fs/node.c
- **git show 1cf6b5670af1f**: Confirmed this is the prerequisite that
  introduced `sanity_check_node_footer()`, first appeared in v6.15-rc1
- **git tag --contains 1cf6b5670af1f**: Confirmed first release is
  v6.15-rc1
- **git show v6.17.13:fs/f2fs/node.c**: Confirmed
  `sanity_check_node_footer` exists (line 1503), and `f2fs_bug_on(sbi,
  folio->index != nid)` still present (the buggy line) at line 1754
- **git show v6.18.10:fs/f2fs/node.c**: Same -
  `sanity_check_node_footer` exists and the buggy `f2fs_bug_on` line is
  present
- **git show v6.17.13:fs/f2fs/f2fs.h**: Confirmed
  `f2fs_handle_critical_error` is declared
- **git show v6.17.13:include/linux/f2fs_fs.h**: Confirmed
  `STOP_CP_REASON_CORRUPTED_NID` exists
- **git show v6.18.10**: Same confirmations for both dependencies
- **git show v6.12.71:fs/f2fs/node.c**: Confirmed
  `sanity_check_node_footer` does NOT exist in 6.12.y (would need more
  work)
- **f2fs_bug_on definition** (fs/f2fs/f2fs.h:34-40): Confirmed that
  without CONFIG_F2FS_CHECK_FS, it's just WARN_ON + SBI_NEED_FSCK,
  allowing execution to continue
- **git show 186098f34b8a5**: Confirmed that c18ecd99e0c70 was
  backported to 6.17.y (combined with prerequisites), establishing
  `sanity_check_node_footer` in stable

This is a small, surgical fix that prevents an infinite writeback loop
on corrupted f2fs node footers. It replaces a weak assertion with proper
error handling and filesystem shutdown. All dependencies exist in 6.17.y
and 6.18.y stable trees. The fix is clearly correct, fixes a real bug
(system hang), and is appropriately scoped.

**YES**

 fs/f2fs/node.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 482a362f26254..a963c4165bc4b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1751,7 +1751,11 @@ static bool __write_node_folio(struct folio *folio, bool atomic, bool *submitted
 
 	/* get old block addr of this node page */
 	nid = nid_of_node(folio);
-	f2fs_bug_on(sbi, folio->index != nid);
+
+	if (sanity_check_node_footer(sbi, folio, nid, NODE_TYPE_REGULAR)) {
+		f2fs_handle_critical_error(sbi, STOP_CP_REASON_CORRUPTED_NID);
+		goto redirty_out;
+	}
 
 	if (f2fs_get_node_info(sbi, nid, &ni, !do_balance))
 		goto redirty_out;
-- 
2.51.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
