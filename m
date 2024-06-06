Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AADC25B75
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Jun 2024 07:34:49 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sF7e6-00042M-79;
	Thu, 06 Jun 2024 07:34:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <eugen.hristev@collabora.com>) id 1sF7e5-00042G-2m
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Jun 2024 07:34:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2vwfvp6akKU7sK6mH+RbvJB4ZNtgoOEykBuGySyoz18=; b=S1nCtXbxDNHPRfXYhnoOvoXqiY
 5nL/ULlO8fRHHZHROQa+YnsqZ8xcHdHMLCXVy4zCpsxjzjwg5fDbfZ1cIE/bSlhATa1exbnOK0hgn
 4saQhCcHEsyvIpxe5ELRi8OTrdPUacUoMURbKj8WDikYLvgHd6zBa1GuNnZACL6nBves=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2vwfvp6akKU7sK6mH+RbvJB4ZNtgoOEykBuGySyoz18=; b=k
 f0OWWDPLkSfUOLVEBQosQCcNaQbDHhmFFlzYXEbGrO/x711Jqs2c/erRu5iL9FFI0afnEWxNecPRn
 uUBlicqMhM6DD5UgWKCXM8vL2XoWyQKDNh8rglz0BJY7MzArYlqIB8Ak1ZYREChmY5OMB9h5OMeu2
 lv+wT5oUhGAOa2cs=;
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sF7e2-0001xM-Gm for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Jun 2024 07:34:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1717659274;
 bh=tNn94IobQd/C8dlz5nPbMB5Ad685R1KlC03nWzyXv4I=;
 h=From:To:Cc:Subject:Date:From;
 b=Efc7Rcf47ESRHoXu0+HlmK5cBJVdHWy5UR8IgXH8GbBe+p60/9hliZ/GLKYQwZ0sx
 mO36fYGcqkzoR7m8wwcQ8ZecWfEjwrZpnsNVh2sPI5xyGb7CrGIaRK4RyZUWa25FQ0
 aQVl/nhjCuN+NtrvvRqZ5JSqEUhQrtCHLfajBlDmGmDpTHtJqZJnTaB8j0VSjNAkNl
 e504pZkKLpIfIDUYak+zdkVrJ3zeFsfW8//VAnp4vWD8nkO2SymQJArKkX1SGgdaL/
 3QYO49kbNaw6A9KO5sc2PKhF9YD+R6OHvsvuKJXv0LvTk6ZFI8ASRmiNThlMk0+0Q4
 CcjH8AMVlYaCg==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7332137821B7;
 Thu,  6 Jun 2024 07:34:33 +0000 (UTC)
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 jaegeuk@kernel.org, adilger.kernel@dilger.ca, tytso@mit.edu
Date: Thu,  6 Jun 2024 10:33:46 +0300
Message-Id: <20240606073353.47130-1-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Headers-End: 1sF7e2-0001xM-Gm
Subject: [f2fs-dev] [PATCH v18 0/7] Case insensitive cleanup for ext4/f2fs
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
From: Eugen Hristev via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: krisman@suse.de, brauner@kernel.org, jack@suse.cz, ebiggers@google.com,
 Eugen Hristev <eugen.hristev@collabora.com>, viro@zeniv.linux.org.uk,
 kernel@collabora.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello,

I am trying to respin the series here :
https://www.spinics.net/lists/linux-ext4/msg85081.html

I resent some of the v9 patches and got some reviews from Gabriel,
I did changes as requested and here is v18.

Changes in v18:
- in patch 2/7 removed the check for folded_name->len
- in patch 4/7 simplified the use of generic_ci_match

Changes in v17:
- in patch 2/7 the case insensitive match helper, I modified the logic a bit,
memcmp params, and return errors properly, also removed patches for logging
errors as the message is now included in the helper itself.

Changes in v16:
- rewrote patch 2/9 without `match`
- changed to return value in generic_ci_match coming from utf8 compare only in
strict mode.
- changed f2fs_warn to *_ratelimited in 7/9
- removed the declaration of f2fs_cf_name_slab in recovery.c as it's no longer
needed.

Changes in v15:
- fix wrong check `ret<0` in 7/9
- fix memleak reintroduced in 8/9

Changes in v14:
- fix wrong kfree unchecked call
- changed the return code in 3/8

Changes in v13:
- removed stray wrong line in 2/8
- removed old R-b as it's too long since they were given
- removed check for null buff in 2/8
- added new patch `f2fs: Log error when lookup of encoded dentry fails` as suggested
- rebased on unicode.git for-next branch

Changes in v12:
- revert to v10 comparison with propagating the error code from utf comparison

Changes in v11:
- revert to the original v9 implementation for the comparison helper.

Changes in v10:
- reworked a bit the comparison helper to improve performance by
first performing the exact lookup.


* Original commit letter

The case-insensitive implementations in f2fs and ext4 have quite a bit
of duplicated code.  This series simplifies the ext4 version, with the
goal of extracting ext4_ci_compare into a helper library that can be
used by both filesystems.  It also reduces the clutter from many
codeguards for CONFIG_UNICODE; as requested by Linus, they are part of
the codeflow now.

While there, I noticed we can leverage the utf8 functions to detect
encoded names that are corrupted in the filesystem. Therefore, it also
adds an ext4 error on that scenario, to mark the filesystem as
corrupted.

This series survived passes of xfstests -g quick.

Gabriel Krisman Bertazi (7):
  ext4: Simplify the handling of cached casefolded names
  f2fs: Simplify the handling of cached casefolded names
  libfs: Introduce case-insensitive string comparison helper
  ext4: Reuse generic_ci_match for ci comparisons
  f2fs: Reuse generic_ci_match for ci comparisons
  ext4: Move CONFIG_UNICODE defguards into the code flow
  f2fs: Move CONFIG_UNICODE defguards into the code flow

 fs/ext4/crypto.c   |  10 +---
 fs/ext4/ext4.h     |  35 ++++++++-----
 fs/ext4/namei.c    | 122 ++++++++++++++-------------------------------
 fs/ext4/super.c    |   4 +-
 fs/f2fs/dir.c      | 105 ++++++++++++--------------------------
 fs/f2fs/f2fs.h     |  16 +++++-
 fs/f2fs/namei.c    |  10 ++--
 fs/f2fs/recovery.c |   9 +---
 fs/f2fs/super.c    |   8 +--
 fs/libfs.c         |  74 +++++++++++++++++++++++++++
 include/linux/fs.h |   4 ++
 11 files changed, 195 insertions(+), 202 deletions(-)

-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
