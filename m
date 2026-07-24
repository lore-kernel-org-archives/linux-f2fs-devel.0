Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70CCC53200
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YCXy+8neeQj7eI1mqRpVXh2mInvA+Ku0L8LDcox0zEY=; b=aagJ79jkBm82hpu6TUt7Op0Td7
	CNm0BFTxKfqztZpjYdZK5ts1W/+BqKiceHmF8ngwsyD1T6Ea/yM53OyRfWNUTtIM8111ggoeT2gx5
	neoezsCvTDrzvlQg/2dR0drwWsSwPGzKjGkiP7keB19HTeOrvAkyfEt9X6oJmS7o0uXQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnHmJ-0001ja-NE;
	Fri, 24 Jul 2026 15:25:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <neelx@suse.com>) id 1wnHmI-0001jT-0S
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:25:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=87KJldLVO12YI6/aqcMypvZbGEc4Q23o2OfJPWjlafE=; b=Aa/gn/eFPcCR9QO0ggTS2FYC9K
 aVnf92Do8yXkWgxP3Co+SbVFFocPSQbcu5p9R+U4sJdvUDvYlQvvnDjkNsp+loGctsf7KrjiUvVNY
 XU6PHs+kxsThw2BLWrLeebFZgiLyc0QEPCQOi3HnAak96hgTdEnGS6rAMutvKD025bGw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=87KJldLVO12YI6/aqcMypvZbGEc4Q23o2OfJPWjlafE=; b=e
 H3d9JNVwyEeJ46etPPjrLGCZJHIz9pGJetLYDphMJgbLctW7soWzXcKF24XKrcvYefmDedW3848iY
 fRHungR23QuJUD+b9Ed7HpcmL+ckvKRvUO80JonF3RVlSY6sMIcwWg5Y/17FZblYA9oiRSA57HAS7
 5YhNcCCwk8LqUUj4=;
Received: from smtp-out1.suse.de ([195.135.223.130])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnHmH-0007Mw-8X for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:25:33 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 59EDB7B88B;
 Fri, 24 Jul 2026 13:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1784900021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=87KJldLVO12YI6/aqcMypvZbGEc4Q23o2OfJPWjlafE=;
 b=hMHi3EVWgudVW3Rtpsa9f6sJYDStIiDsU507vjY2B72mqcuP4Ckx6E3eLT1b9Gf/Ng1Fyw
 Cr7k0Oz79bSZpwo0QMCO3Arc+4IUNQv1SdkQANJl14+v+otVdWWDxNWuWR55+Idz478ODU
 D5WWY893wSPTtMERn8fnFt0W4Lz12SM=
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.com header.s=susede1 header.b=hMHi3EVW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1784900021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=87KJldLVO12YI6/aqcMypvZbGEc4Q23o2OfJPWjlafE=;
 b=hMHi3EVWgudVW3Rtpsa9f6sJYDStIiDsU507vjY2B72mqcuP4Ckx6E3eLT1b9Gf/Ng1Fyw
 Cr7k0Oz79bSZpwo0QMCO3Arc+4IUNQv1SdkQANJl14+v+otVdWWDxNWuWR55+Idz478ODU
 D5WWY893wSPTtMERn8fnFt0W4Lz12SM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12998779C3;
 Fri, 24 Jul 2026 13:33:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id redGM7JpY2pIJgAAD6G6ig
 (envelope-from <neelx@suse.com>); Fri, 24 Jul 2026 13:33:38 +0000
To: fstests@vger.kernel.org
Date: Fri, 24 Jul 2026 15:33:16 +0200
Message-ID: <20260724133328.1837318-1-neelx@suse.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCPT_COUNT_SEVEN(0.00)[11];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.com:s=susede1]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Queue-Id: 59EDB7B88B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Headers-End: 1wnHmH-0007Mw-8X
Subject: [f2fs-dev] [PATCH 00/12] fstests: introduce fscrypt support for
 btrfs
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
From: Daniel Vacek via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Daniel Vacek <neelx@suse.com>
Cc: hch@infradead.org, Daniel Vacek <neelx@suse.com>, djwong@kernel.org,
 zlang@redhat.com, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 David Sterba <dsterba@suse.com>, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This is a rebase and cleanup of older patches [0] from Sweet Tea and Josef
fixed to work with the recent kernel and btrfs-progs changes.

[0] https://github.com/btrfs/fstests/tree/fscrypt (227ac42)

Daniel Vacek (1):
  fscrypt-crypt-util: add support for per extent KDF

Josef Bacik (4):
  fstests: properly test for v1 encryption policies in encrypt tests
  fstests: split generic/580 into two tests
  fstests: split generic/581 into two tests
  fstests: split generic/613 into two tests

Sweet Tea Dorminy (7):
  common/encrypt: separate data and inode nonces
  common/encrypt: add btrfs to get_encryption_*nonce
  common/encrypt: add btrfs to get_ciphertext_filename
  common/encrypt: enable making a encrypted btrfs filesystem
  common/verity: explicitly don't allow btrfs encryption
  btrfs: add simple test of reflink of encrypted data
  btrfs: test snapshotting encrypted subvol

 common/encrypt           |  94 ++++++++++++++++++++++++----
 common/verity            |   4 ++
 src/fscrypt-crypt-util.c |  12 +++-
 tests/btrfs/613          |  54 ++++++++++++++++
 tests/btrfs/613.out      |  13 ++++
 tests/btrfs/614          |  73 ++++++++++++++++++++++
 tests/btrfs/614.out      | 111 ++++++++++++++++++++++++++++++++
 tests/f2fs/002           |   2 +-
 tests/generic/580        | 118 +++++++++++++++-------------------
 tests/generic/580.out    |  40 ------------
 tests/generic/581        |  89 +-------------------------
 tests/generic/581.out    |  50 ---------------
 tests/generic/593        |   1 +
 tests/generic/613        |  24 +++----
 tests/generic/613.out    |   5 +-
 tests/generic/798        |  77 +++++++++++++++++++++++
 tests/generic/798.out    |  44 +++++++++++++
 tests/generic/799        | 132 +++++++++++++++++++++++++++++++++++++++
 tests/generic/799.out    |  51 +++++++++++++++
 tests/generic/800        | 115 ++++++++++++++++++++++++++++++++++
 tests/generic/800.out    |  14 +++++
 21 files changed, 845 insertions(+), 278 deletions(-)
 create mode 100755 tests/btrfs/613
 create mode 100644 tests/btrfs/613.out
 create mode 100755 tests/btrfs/614
 create mode 100644 tests/btrfs/614.out
 create mode 100755 tests/generic/798
 create mode 100644 tests/generic/798.out
 create mode 100755 tests/generic/799
 create mode 100644 tests/generic/799.out
 create mode 100755 tests/generic/800
 create mode 100644 tests/generic/800.out

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
