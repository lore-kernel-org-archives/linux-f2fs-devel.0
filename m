Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5745606A321
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 13 Nov 2026 07:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NIc3l4ru;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Vh+EzNe9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=C7GSO45o;
	dkim=neutral header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CnVpsDvA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Mime-Version:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=0wrI1KOBXr5G8F1Ol2rfMN2P6O3P6bemHgfdmozswhU=; b=NIc3l4ruwavxPud6tjSntYAXPb
	nb3+jbHlXCPUX0pJeniE0nk4mN7KF2v7JRyWsyqsi+UzEMS6JpnQM3KWyFY/W+8FVFaymAYQKnx/i
	RL9G6UMQ3A5wa2OobqLgBo2r/nJgf7APbwLxixkRLki1aCnm6ax1aowvjdJmC9puxK9w=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRlbi-0000000008O-1YEl;
	Fri, 13 Nov 2026 07:21:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1) (envelope-from
 <38rP2ag4KAJMFxEG4x77H7E1G53BB381.zB9@flex--sarthakkukreti.bounces.google.com>)
 id 1xRlbX-0000000007H-0pyv
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 07:21:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 Mime-Version:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eRq6wTCSjBW5NE3wTloFuQbWBWvxneqtC2vRx7rsxKw=; b=Vh+EzNe9bvk2W/G3ea+TbNVPpP
 ODXjqWxeMzq6mXylgMDzSr2kPARj1SKdOqqs70JTF00Ze6ISiKobJlIjWA7JAXUwWn3fEwpbos3Eh
 zkj82l764G6vebGz5NBnjA29clQAX7u8KQiTDFs3VVZXDIIcIz/Nukjx2ZPslrQWio7Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:Mime-Version:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eRq6wTCSjBW5NE3wTloFuQbWBWvxneqtC2vRx7rsxKw=; b=C7GSO45o0hH3f1qkA0250rIEyS
 gZh0lU1oPmw+ntObxlPITmnNb7UQCOz/W8ZBQtGlWAOWKhIJGGnRreHjHr2Cka/U8RjDukbPL5b8/
 SPa1caKxaYNY3nPK6+RHzP14aks2lTJRmssaC/cRwL0jw0ZjnBjrmkveztK7e3sGPNmU=;
Received: from mail-ua1-f70.google.com ([209.85.222.70])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRlbW-000000002Nl-3Q7i
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 07:21:47 +0000
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-9905fc56b60so669833241.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 23:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794554501; x=1795159301;
 darn=lists.sourceforge.net; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eRq6wTCSjBW5NE3wTloFuQbWBWvxneqtC2vRx7rsxKw=;
 b=CnVpsDvAmcIk6YpSHsQ/+/mS4Qk62IBdDrX+VhTWQJrkm/lcwX9BZcnNVVloNYodpw
 um9gEiCFwVhe7XLfXDYM3YenivY3qKBUnf5l2gdf4R7+2hyZ+FpGaS4WWaG4kwksaAHA
 51GeeKeyyWULczHQ4Mwn7ZfVQoIRbZSzrhT6pGqpy0Q6yTZUfniBAFKvI0M+uXNh7nVZ
 111jl1W4blXXPBlt4vYNUdxAgsKx3BdgDQosgJzVFwGUIhzJoxi9zV38vDZHgMmST8Mk
 cfYP1ptSSnctuLgrhJvhVWeaPCi+d3BjRmJhN3vM+R/p4sIAsosoZtz9Ia7myAY8Tc6k
 6Qnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794554501; x=1795159301;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eRq6wTCSjBW5NE3wTloFuQbWBWvxneqtC2vRx7rsxKw=;
 b=MRuWGtGynKMQ9THb6if7f6pznI8aMlG6olST6IVgDsHIKEYBa0Qw997V8BxiRvcMQd
 WkEdIpoZJPMlobZy/kh0TMqPLehQACNeI5RSVojHNwX3X87MsIISXBnX1y/huchjaB+i
 2qKimiPLVWNTO8zkySMVeb4+Igfbg3VRmUVEG2b+QnPh6LIovFAVfCKe6HUhlthyJ00i
 TuClJsvf+lQzrf37yKZ1xjttiqZ8gpra3D5840vLRA6WDIsriSoEmXdYf7C62OfCGPzn
 9Ure78XzSZDuMbO3EV4lEwqKJg7hPv0HFfOqHr+Q3ko1GDxoGbmIy8AonWzZEC6CPVEF
 nL9Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGyIrNpr/eWlZGZNbVQS53SGkVPzg3yIU+DzCIjPQdeSVbptMlUzoUoEsKGXrylu/2hxyrjcOSJQTb2MqcGtn/f@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/mckjdBR2ep6M/v3g4BGooxCc9yL/DL8d1c8vO8eED2CQYpSMk
 3uakGY3ybt19uvbQVP9X48IGXuoX4/0jTkcKEX0Q2pCWGP1ahM9+gOVZrwqSE27hG0vkRElQEXB
 o2apAiB2hftcoOuer0TK/shAT8o5Wsf3FR7npvw==
X-Received: from dybml12.prod.google.com ([2002:a05:7301:150c:b0:36a:209:2e4])
 (user=sarthakkukreti job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:80cd:b0:377:82e:2d79 with SMTP id
 5a478bee46e88-377e093ecaamr4738406eec.9.1794552818284; 
 Thu, 12 Nov 2026 22:53:38 -0800 (PST)
Date: Thu, 12 Nov 2026 22:53:29 -0800
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261113065332.929085-1-sarthakkukreti@google.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
X-Spam-Score: -7.6 (-------)
X-Headers-End: 1xRlbW-000000002Nl-3Q7i
Subject: [f2fs-dev] [PATCH 0/3] fs: reject casefolded names that fold to ".", "..",
 or empty
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
Cc: Eric Biggers <ebiggers@google.com>,
 Sarthak Kukreti <sarthakkukreti@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.co.uk>,
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
characters (such as U+202E RIGHT-TO-LEFT OVERRIDE and U+200B ZERO WIDTH
SPACE) in both UTF8_NFDI and UTF8_NFDICF. In casefolded directories,
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
   bytes), causing distinct ignorable-only filenames to hash and compare
   equal and creating entries that e2fsck flags as corruption.

This series rejects casefolding and case-insensitive matching of names
that fold to "", ".", or ".." across libfs (d_hash, d_compare,
generic_ci_match, and generic_ci_validate_strict_name), ext4
(ext4_fname_setup_ci_filename and ext4fs_dirhash), and f2fs
(f2fs_init_casefolded_name), while preserving exact byte-equality
matching for genuine "." and ".." lookups (such as NFS ext4_get_parent)
and opaque byte fallback for invalid UTF-8 sequences in non-strict mode.

Dmitry Torokhov (1):
  f2fs: reject casefolded names that fold to ".", "..", or empty

Sarthak Kukreti (2):
  libfs: reject casefolded names that fold to ".", "..", or empty
  ext4: reject casefolded names that fold to ".", "..", or empty

 fs/ext4/hash-test.c | 12 ++++++++++++
 fs/ext4/hash.c      |  2 +-
 fs/ext4/namei.c     | 11 +++++++++--
 fs/f2fs/dir.c       |  6 +++++-
 fs/libfs.c          | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/fs.h  | 29 +++++++++++++----------------
 6 files changed, 91 insertions(+), 21 deletions(-)

-- 
2.56.0.611.g1030f0b940-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
