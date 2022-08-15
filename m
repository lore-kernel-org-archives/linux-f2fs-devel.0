Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76ABC25B0D
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Aug 2022 23:51:54 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oNjs9-0005TE-Bs;
	Mon, 15 Aug 2022 23:51:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1oNjs7-0005T8-FR
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Aug 2022 23:51:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OWWtVBYLO/Pqd1I7nujHmVjGOYmS3OVNjIga0GQlwyQ=; b=RbPr78NxG5YU/nS8YyUsAFBRvT
 bYEzvGdyR+KcY2uRfzKQPwR0uZLwurWgcaXA0qCWeVvZc+8EuRQbH2tawwaR/lcGsVrDgRvivPQNb
 HGjIabvC0I89qyU6o04BkCVZ0uifocK0vDvl07uIsdvzoOAqioQoHgb/DQYlQ9kDgQ/M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=OWWtVBYLO/Pqd1I7nujHmVjGOYmS3OVNjIga0GQlwyQ=; b=B
 EsuOOaol2qKo8i+6Li+g0pHrvgwWdWbqMBCAQd48HjoKb8ngxf31CFMZS3l0nSx7EJNTJItjFNvYn
 UHMqx6GpS8pm8XetyLTpfvaA9sGbycPoieaghRgIvAg5nAA2lfte3eAHW1CZ8ipwaYaZe2cxG9jCf
 eZc+PlnyF2v9GYYA=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oNjs6-0001oo-QS for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Aug 2022 23:51:51 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 90F47B81235;
 Mon, 15 Aug 2022 23:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC64C433C1;
 Mon, 15 Aug 2022 23:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1660607503;
 bh=BeW1orVomShlhYcBAjKKGjagqLCAQpws3J+NC4g2hME=;
 h=From:To:Cc:Subject:Date:From;
 b=TrivuLOkxHxPfwsnHACeReH/1VdknVQsfy5hmeruzqK4bWYGxj6ofnxdjdaPQoBk8
 Fyf0apfS6yA0Asj7sGShx3myy96y6e7HZuPXkUhj35RDznqskOGPGQ8hY78DZeoIba
 laxy1vqVXP/PzsJUVuub3utAcRA9N/LaDD34DXNCzt7dAF40H4GFcMD0sCOWrragdh
 QwtncR0MihrPf9P8QbT0tS+pYgHffg3glP/HarbZx4HYpR9rbwYqss7bIVZyDHhCsu
 ncYFUtKH6GSFhyZn5FarB2HsR2J7yqi9oHQxICIDZsahhnwMsLGbxb+MD97leIDOGM
 DpYOBENQusP9g==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Mon, 15 Aug 2022 16:50:50 -0700
Message-Id: <20220815235052.86545-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Headers-End: 1oNjs6-0001oo-QS
Subject: [f2fs-dev] [PATCH v2 0/2] ext4,
 f2fs: stop using PG_error for fscrypt and fsverity
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
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This series changes ext4 and f2fs to stop using PG_error to track
decryption and verity errors.  This is a step towards freeing up
PG_error for other uses, as discussed at
https://lore.kernel.org/linux-fsdevel/Yn10Iz1mJX1Mu1rv@casper.infradead.org

Note: due to the interdependencies with fs/crypto/ and fs/verity/,
I couldn't split this up into separate patches for each filesystem.
I'd appreciate Acks from the ext4 and f2fs maintainers so that I can
take these patches.  Otherwise I'm not sure how to move them forward.

Changed v1 => v2:
   - Rebased onto v6.0-rc1 and resolved conflicts in f2fs.

Eric Biggers (2):
  fscrypt: stop using PG_error to track error status
  fsverity: stop using PG_error to track error status

 fs/crypto/bio.c         | 16 +++++++----
 fs/ext4/readpage.c      | 16 +++++------
 fs/f2fs/compress.c      | 64 ++++++++++++++++++++---------------------
 fs/f2fs/data.c          | 64 +++++++++++++++++++++++------------------
 fs/verity/verify.c      | 12 ++++----
 include/linux/fscrypt.h |  5 ++--
 6 files changed, 93 insertions(+), 84 deletions(-)


base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.37.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
