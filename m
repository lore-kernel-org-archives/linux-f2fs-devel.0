Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C84C02188
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 17 Jan 2025 16:44:10 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tYpS5-000430-QT;
	Fri, 17 Jan 2025 16:44:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1tYpS4-00042q-KI
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 17 Jan 2025 16:44:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2+JIAiGL8Ec/jM7vHDkDiewXcF0xqWmqkST0LCnNpTo=; b=eONm/2Yipynerhgjb9vFTaBK3u
 LACU0Ch/6Lusmx9Be9vCfDvJpa3Cghe7IT4fWsSY8hZkKBlNGrED3JLLEJ92RZh1x9d32kakoANEt
 VOfX476RzR6GpHIIrBbdb7uGnilpT8bCvo+Qy1WwzzR7c6VbMai5J5ZPvaoLSuof2b2s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2+JIAiGL8Ec/jM7vHDkDiewXcF0xqWmqkST0LCnNpTo=; b=G
 NXwoOBqSo1ia1Ves2W7wD5RbcNPqnH24u/1hHGsw9d2jMBAj9f3GrOu6oCDay6D2+gi6T3ZjGc1xz
 1EwwAGQngWScQYJHRm9PN03XrIhUawh58C2YFdS5aAAW6oc+0oxm0cjTnZt8n/2+4haL7xhuX01rO
 t4xjR1LjT2dHKx8Q=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tYpS3-0005JN-Sx for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 17 Jan 2025 16:44:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 47A07A4321D;
 Fri, 17 Jan 2025 16:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED05C4CEDD;
 Fri, 17 Jan 2025 16:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737132236;
 bh=S02F2sVetY7kvvykNiDGJwlwNft/i3THYzyTiCi3N6I=;
 h=From:To:Cc:Subject:Date:From;
 b=Kyo2yhKf/2sXZJoY5Nj661rDPYbywRn6sgwZGlLRMqe3rITI93OISYLUUSG7M6PsU
 5x3XybunpHjikgKJshxh+Ty4iR6XZBh/IKbNaRKO3PNeV6nOu/iOHmpcu4jzJ2Iyja
 /gJ65RiXJi4yx3AhyIAMsMBjfMvu4m57WYNK1mY20Hy+xYEqpryozF43Yx+mK6gWhl
 uxdVDBuf36B2jyButU/WodKR2jJ0o/WfdZCxpoi5GU2h618uJPG5Hfsbvr6QbnZTdJ
 mwjOBMLkuLFi/aTK2lWSLlv/KYta1psDhCJm6jcH/nPZKJ9Y0gtygFxX5C0u5FIGQU
 S53qI9Deohw0Q==
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 17 Jan 2025 16:41:16 +0000
Message-ID: <20250117164350.2419840-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
MIME-Version: 1.0
X-Headers-End: 1tYpS3-0005JN-Sx
Subject: [f2fs-dev] [PATCH 0/2 v6] add ioctl/sysfs to donate file-backed
 pages
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

If users clearly know which file-backed pages to reclaim in system view, they
can use this ioctl() to register in advance and reclaim all at once later.

To MM and others,

I'd like to propose this API in F2FS only, since
1) the use-case is quite limited in Android at the moment. Once it's generall
accepted with more use-cases, happy to propose a generic API such as fadvise.
Please chime in, if there's any needs.

2) it's file-backed pages which requires to maintain the list of inode objects.
I'm not sure this fits in MM tho, also happy to listen to any feedback.

Jaegeuk Kim (2):
  f2fs: register inodes which is able to donate pages
  f2fs: add a sysfs entry to request donate file-backed pages

 Documentation/ABI/testing/sysfs-fs-f2fs |  7 +++
 fs/f2fs/debug.c                         |  3 ++
 fs/f2fs/f2fs.h                          | 14 +++++-
 fs/f2fs/file.c                          | 65 +++++++++++++++++++++++++
 fs/f2fs/inode.c                         | 14 ++++++
 fs/f2fs/shrinker.c                      | 27 ++++++++++
 fs/f2fs/super.c                         |  1 +
 fs/f2fs/sysfs.c                         |  8 +++
 include/uapi/linux/f2fs.h               |  7 +++
 9 files changed, 145 insertions(+), 1 deletion(-)

-- 
2.48.0.rc2.279.g1de40edade-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
