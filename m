Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B17C3DA41
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 11 Jul 2024 07:49:31 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sRoYU-0004N9-N3;
	Thu, 11 Jul 2024 07:49:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <youling.tang@linux.dev>) id 1sRoYS-0004N3-U8
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 11 Jul 2024 07:49:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oGIWSDUMzn+gpjSzQ+REy8Wj9tSDNlALob7dYQowUWA=; b=Ph0PfS1jnLGrgyF5JcWIymgWM4
 GxGoOzsSHmzg6smKTDCven/Tl6khSrUzoZEEQT2bb2zNAOTDM6iRawG3GP3j1LjB4GVbeMfjKpCDg
 zFTbZhWM4Mu1xSCtcMqQFfLmDn+YE5kicU0mgXD3DkpwJJOUbWoaSAdhYw+ltK1oSSTI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=oGIWSDUMzn+gpjSzQ+REy8Wj9tSDNlALob7dYQowUWA=; b=X
 He59aGKOWA1+TjPXxCC4DrjB4t6uR1ukaeFg2sG5s4kh1js56TBuZKh4d2rc5uK+MIO8QMjlkepuB
 dC5l4dTZOJX8BZGFuZoGyWN6FMJwc1oh/IzcaJwYNbIdRMyeZMdqB+8EIdmqL1iT5qKFUAuadO7rh
 oLK9aqFI8GA3zt8Y=;
Received: from out-171.mta1.migadu.com ([95.215.58.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sRoYO-0008UM-8U for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 11 Jul 2024 07:49:28 +0000
X-Envelope-To: viro@zeniv.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1720684151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=oGIWSDUMzn+gpjSzQ+REy8Wj9tSDNlALob7dYQowUWA=;
 b=vSphCIq/5+7V++7Ee47RhuofdTFRsIbDZDd2em7d5TRe2CvFZJWqrhgPIJnhINB0iwm7MY
 hbL1EbMfHMZD6z7I8T9/QqGUubBWBkRgUrmMyNGshTiYsu4Sc6cjSheMAIS8MFs/yrZBwf
 j66VOCYvq3rC6bSOzbng20tB6Gb7fa0=
X-Envelope-To: brauner@kernel.org
X-Envelope-To: jack@suse.cz
X-Envelope-To: clm@fb.com
X-Envelope-To: josef@toxicpanda.com
X-Envelope-To: dsterba@suse.com
X-Envelope-To: tytso@mit.edu
X-Envelope-To: adilger.kernel@dilger.ca
X-Envelope-To: jaegeuk@kernel.org
X-Envelope-To: chao@kernel.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-btrfs@vger.kernel.org
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: linux-f2fs-devel@lists.sourceforge.net
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: youling.tang@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Youling Tang <youling.tang@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, tytso@mit.edu,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Date: Thu, 11 Jul 2024 15:48:56 +0800
Message-Id: <20240711074859.366088-1-youling.tang@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Headers-End: 1sRoYO-0008UM-8U
Subject: [f2fs-dev] [PATCH 0/3] Add {init,
 exit}_sequence_fs() helper function
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 youling.tang@linux.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This series provides the {init, exit}_sequence_fs() helper functions and
applies to f2fs and ext4, similar to btrfs.

Youling Tang (3):
  f2fs: make module init/exit match their sequence
  ext4: make module init/exit match their sequence
  fs: Add {init, exit}_sequence_fs() helper function

 fs/btrfs/super.c   |  36 +--------
 fs/ext4/super.c    | 142 +++++++++++++++---------------------
 fs/f2fs/debug.c    |   3 +-
 fs/f2fs/f2fs.h     |   4 +-
 fs/f2fs/super.c    | 178 ++++++++++++++++++---------------------------
 include/linux/fs.h |  38 ++++++++++
 6 files changed, 173 insertions(+), 228 deletions(-)

-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
