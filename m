Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5360F606A320
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Nov 2026 21:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iorQJC1k;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=E/jc1pHx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LLp7HYNy;
	dkim=neutral header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bdd4cVGF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Mime-Version:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=CUnNH0dMFE8uAptc9+aNnRk+wDtkMAodxLy5zit+xSc=; b=iorQJC1kruFqu/jPR2bShvzHrZ
	Y7ryQdeXF7Y+33Wc/Gcoetid5FjXws8OIYktrtU5W2YdWo1MYCKV8fsPyNsgOXxMA+ng5Ctz626jj
	LKQHgLaogvziOr7ktM00t/jMeyqUSxVGB7I7LqGfu9LNeMAeNn3AHWXyuK2JmKpBGCqY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUA8Q-0000000074S-0Clb;
	Thu, 19 Nov 2026 21:57:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1) (envelope-from
 <3-27_ag4KADYkSjlZSccmcjWlaYggYdW.Uge@flex--sarthakkukreti.bounces.google.com>)
 id 1xUA8P-0000000074L-01mH
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 21:57:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 Mime-Version:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YXrRbt6HWzKxojcR8GMFb/SNva/fbUrA1VGUZ9GDT4w=; b=E/jc1pHxy0/n5nfw7B0f3u3eV8
 sGkJw+++ebQIpLUYrVdLv6zywstO+Ars030jFitfcsz2EAHQhPyNF/rm90u4svbN8D930oSW0kFv0
 tS0DrHdszOZial70IoLV2cMsv8Hl/zLk/2IMNihHcxb1lZkabcKTtOoNXAFgwuT3RSnE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:Mime-Version:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YXrRbt6HWzKxojcR8GMFb/SNva/fbUrA1VGUZ9GDT4w=; b=LLp7HYNyTBCLfhfBZBEcZ0+61X
 6NukOzk4IjqgFTEfS+ym3iB7Y6XvqSfDQzcS61bRXSuMUBoY1RsSqmUY1+bCWpbtrLQ/SHsiBKQLp
 72NX0Hnyz+raHDEuSO9gJ/Gc0Qfv5jM9UNgeBVKAb1xHurFfzvq0ik+6xC5g6VjWWlsQ=;
Received: from mail-ua1-f71.google.com ([209.85.222.71])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUA8O-000000004kj-1Q9I
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 21:57:36 +0000
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-99e109028b4so196686241.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 13:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795125450; x=1795730250;
 darn=lists.sourceforge.net; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YXrRbt6HWzKxojcR8GMFb/SNva/fbUrA1VGUZ9GDT4w=;
 b=bdd4cVGFomsYszakezDSuAFL6K/tOZFhhxWjL76/1m6MdwJFDJA8CbNLUm3wahwHUa
 J39GYSSrErDr1r7Qvgjq35wrMncMFuycfJGi5TZs4KbfoDkKGEfnLReFuCxK4aKGO7a5
 ZXva01zdsInUfphH87S7TdpnOo5FPtPp41rmfEzloBW0IUJBfAB4VAY4jiMm9Zqr4Vq4
 n7sQTFWA9Y9y+zCfkFH/+VBqOpQlyyPOdemFrrHYhs8Z9UupNTia13MQ6HtVDFq9qczl
 OH/IreLcKpoOqvPhs+pBXT9VRBjUZI0F6X1OO6D3u0NmIqkY9jaW0XW9fA7ZSZJwokVW
 tYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795125450; x=1795730250;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YXrRbt6HWzKxojcR8GMFb/SNva/fbUrA1VGUZ9GDT4w=;
 b=nhALNW9nljZYSBQJxY3YALD4G2lDuH0qWduqyN8+f+MwOeAXKU823x9qmZVJQyjf79
 nED5H6SaiZtzFrcXv0vJWO+SNBSiia24jnbR5GguB1M/7sLvmfkXJVKCT68CVnfmYyYo
 qMPNW0xPugtIBirmgh1961nDE2jvREyHTIL7TdsXAJfY4sn4+fIRI1tJir256jXxteVW
 5S93NLDXdS4qbNPrPXFvYDxROfqxc9gkfUiNnqitUb8K42cuRTbTtBcRmRpO9/WWFP8K
 ZqpES1QXvSxe6FTAB1776040NAFM+gYkglp1p9Oaqd43ScVwoIB20Jkx/wxSX1Pv+Ynk
 NvsA==
X-Forwarded-Encrypted: i=1;
 AL+hErF8DbfFnmULnQmyUQ4YeemeMWGpLdhAEU0BnoRQSTx1PzGnHG3Oi1azoJMoksmzRBxTqa+XkM+VWpkPYp0n3Qc0@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8T0hGSRLVNN0fT/l8fVQu3QyX+3NNPLFlysnVGasYptfflKR8u
 x/atSnlY7BE+sFLbykKs7e4VH1A+7JdBuWF1VUBg6YY7Xt9n0Nk5oLqA+Hh2+MLG914rvC3JpCb
 NZgXT0lJKDqSjUNXj89lw87odGPs1J+STyh+4iA==
X-Received: from dled6-n2.prod.google.com
 ([2002:a05:701b:42c6:20b0:19a:9ffd:b30e])
 (user=sarthakkukreti job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701a:ccc9:10b0:166:f097:6f12 with SMTP id
 a92af1059eb24-1b5568b3e73mr812728c88.15.1795124987927; 
 Thu, 19 Nov 2026 13:49:47 -0800 (PST)
Date: Thu, 19 Nov 2026 13:49:41 -0800
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119214944.1480596-1-sarthakkukreti@google.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, 
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
X-Spam-Score: -7.6 (-------)
X-Headers-End: 1xUA8O-000000004kj-1Q9I
Subject: [f2fs-dev] [PATCH v2 0/3] fs: reject casefolded names that fold to
 ".", "..", or empty
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Sarthak Kukreti via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Sarthak Kukreti <sarthakkukreti@google.com>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
 Sarthak Kukreti <sarthakkukreti@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Unicode normalization in fs/unicode strips Default_Ignorable_Code_Point
characters in both UTF8_NFDI and UTF8_NFDICF. In casefolded directories,
filenames consisting of 0 to 2 ASCII dots plus ignorable code points
(e.g. "\u202e", ".\u202e", "..\u202e") pass VFS path walk as normal
multi-byte components, but fold to "", ".", or ".." in utf8_casefold():

1. Looking up ".\u202e" folds to "." and matches the on-disk "." entry
   (de->inode == dir->i_ino) in generic_ci_match(), triggering
   EXT4_ERROR_INODE ("linked to parent dir") in ext4_lookup().
2. Looking up "..\u202e" folds to ".." and matches the on-disk ".."
   entry, returning -ELOOP via d_splice_alias() (or triggering
   EXT4_ERROR_INODE on the root directory).
3. Filenames consisting solely of ignorable characters fold to "" (0
   bytes). On ext4, the first such file is created on disk and
   subsequent ignorable-only names collide with it (-EEXIST); on f2fs,
   f2fs_init_casefolded_name() treats len == 0 as a fallback to raw
   bytewise hashing/matching, writing multiple ignorable-only files to
   disk that fsck.f2fs flags with hash mismatches.

This series rejects casefolding and case-insensitive matching of names
that fold to "", ".", or ".." across libfs (generic_ci_d_hash,
generic_ci_match, and generic_ci_validate_strict_name), ext4
(ext4_fname_setup_ci_filename and ext4fs_dirhash), and f2fs
(f2fs_init_casefolded_name), while preserving exact byte-equality
matching for genuine "." and ".." lookups (such as NFS ext4_get_parent)
and opaque byte fallback for invalid UTF-8 sequences in non-strict mode.

Changes in v2:
- Drop redundant generic_ci_d_compare() changes from patch 1.
- Add Fixes: tags for initial ext4 and f2fs casefolding support to patch 1.
- Clarify ext4 vs f2fs behavior for ignorable-only filenames.

Link: https://lore.kernel.org/r/20261113065332.929085-1-sarthakkukreti@google.com # v1

Dmitry Torokhov (1):
  f2fs: reject casefolded names that fold to ".", "..", or empty

Sarthak Kukreti (2):
  libfs: reject casefolded names that fold to ".", "..", or empty
  ext4: reject casefolded names that fold to ".", "..", or empty

 fs/ext4/hash-test.c | 14 ++++++++++++++
 fs/ext4/hash.c      |  2 +-
 fs/ext4/namei.c     |  9 +++++++--
 fs/f2fs/dir.c       |  6 +++++-
 fs/libfs.c          | 32 +++++++++++++++++++++++++++++---
 include/linux/fs.h  | 31 ++++++++++++++++++-------------
 6 files changed, 74 insertions(+), 20 deletions(-)

-- 
2.56.1.703.gf848ed807c-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
