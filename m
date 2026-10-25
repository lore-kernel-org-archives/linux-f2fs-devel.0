Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13DB606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 25 Oct 2026 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=a3H7gtJ0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fZd+D4BW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bi1jhWof;
	dkim=neutral header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=lUTZwNHb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=LieCLpIkMQexjXwe/GvEl+P35NJ3wY1AOK45MFcjaAQ=; b=a3H7gtJ0yz+efIMU1pdR0LKTP2
	m0IPLBJW0vqM5dH3ycy4GlBgQoOjGfZQYGMKIi2uWi52iUYpW793A8Qp8srxvjgJtxy1EeItF7Rxz
	Wx1hgecejmAOhoubRRu+9tezIsa10WeZ9uYHfLeYfls8IByqSJD06Rb2IPAmDYJFYuu8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xKxYL-000000006K9-1bED;
	Sun, 25 Oct 2026 12:42:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <yaojiale02@163.com>) id 1xKxYJ-000000006K3-3kGw
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 12:42:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jzdJu2icUPc9CnDzC7FIAa4FNFGtvGnsVmr7zsS0YHg=; b=fZd+D4BWp69Jp7RD/ovfg0XZYf
 O2l7p1pc9xXDkW6jCEg+3LsegK4qXZCA5iLnieXE604lG63wnIwIOT2Zq4tKTcuJApZi+BIPhuCPL
 bEi9OPp6CjZiy0jVcSLbOri/GVJM9MHWk4qmG66N6SFakOJgSFl8VwvxUzfU+UYaWv+c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:To:From:
 Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jzdJu2icUPc9CnDzC7FIAa4FNFGtvGnsVmr7zsS0YHg=; b=bi1jhWofmAF1u+zz7X3HbKwguZ
 7pjTDlK3vM0EYS561z67xKfFEBMzaSO6gPGxIV6+cZ6fZ2F/7rQ3Ra4zDTCS4n860qbC7/q89/b78
 cV92qJOr75BIEQMzh/tiRAGnlXieOookt/ivp2EcglGTFENTOTWTyW9vDlNi3o39InL8=;
Received: from m16.mail.163.com ([220.197.31.2])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xKxYI-000000000oz-3zbC
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 12:42:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=jz
 dJu2icUPc9CnDzC7FIAa4FNFGtvGnsVmr7zsS0YHg=; b=lUTZwNHbPI14KMm28l
 kFus1ccG7pVSpymo2FLeHADG3bdl8pom70kUMdFmR9oa5IWB3tZbJYATR6WBE53Y
 BeQREfn7/H8gMBGnFQt36lH+uVtwtu7OKrvTikQXNhr8QXxKYQLe50QQeJ8QAIn/
 /isepYwN7a0Il7LmFprXk0FBM=
Received: from pc.localdomain (unknown [])
 by gzsmtp3 (Coremail) with SMTP id PigvCgDnvTzs+N1qxJALCA--.54355S2;
 Sun, 25 Oct 2026 20:41:18 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Carlos Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Eric Biggers <ebiggers@google.com>,
 Dave Chinner <david@fromorbit.com>, "Darrick J. Wong" <djwong@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
Date: Sun, 25 Oct 2026 20:41:09 +0800
Message-Id: <20261025124115.3178287-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: PigvCgDnvTzs+N1qxJALCA--.54355S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrZFWktF1DWrWUXrW8tFy8uFg_yoW8Jr48pF
 98Kr4YyrnFyrZ7urn3u3W7Xw1rKr4rZ343ua17W34DKrWDXr4UXw48tF1Uuw1rAw47Xr13
 tw4FvFykWryjy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jerWrUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8A+LxWrd+O8PLgAA3w
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xKxYI-000000000oz-3zbC
Subject: [f2fs-dev] [PATCH 0/5] fs: drain in-flight DIO before buffered
 writes
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

An asynchronous direct write can remain in flight after its submitting
thread releases the filesystem's I/O submission lock. If a buffered write
dirties page cache before that direct write completes, post-I/O page-cache
invalidation can find dirty pages, report possible data corruption, and
record -EIO in the mapping error sequence.

Drain in-flight DIO before buffered writes in the generic filemap path,
F2FS, XFS, and zonefs. The filemap change also protects UDF and other
users of __generic_file_write_iter(). Keep IOCB_NOWAIT requests
nonblocking by returning -EAGAIN when a drain would be required.

The patches are separated by common code or filesystem and remain
independently buildable in series order.

Jiale Yao (5):
  filemap: drain in-flight DIO before buffered writes
  f2fs: drain in-flight DIO before buffered writes
  xfs: drain in-flight DIO before buffered writes
  xfs: drain in-flight DIO before zoned buffered writes
  zonefs: drain in-flight DIO before buffered writes

 fs/f2fs/file.c    | 13 +++++++++++--
 fs/xfs/xfs_file.c | 22 ++++++++++++++++++++++
 fs/zonefs/file.c  |  8 ++++++++
 mm/filemap.c      |  9 +++++++++
 4 files changed, 50 insertions(+), 2 deletions(-)

-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
