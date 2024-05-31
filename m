Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8837FC25B74
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 31 May 2024 01:40:53 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sCrGH-0004Sb-DA;
	Fri, 31 May 2024 01:40:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sCrGG-0004SV-0c
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 31 May 2024 01:40:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D7C3lBabigZMNui+qxl83Ex1vMxrZy0rdpfeDZ84W2s=; b=PkVNZAq2AK9IoBK0tk20Agqpw1
 9JpuQiWWvoYmXdHBp2MlWuQ1lX/8QY0JzAvA5+/cIcCVqkWJMuUZMfJbFIV+92iz4R9HhuHIBsJyx
 r6w6zEkCcV6f+SkRZ3T6rCqbpTrkmzkncsgpBraXXZP/iHoLM+C4t7FT/F0fvdxftWM0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=D7C3lBabigZMNui+qxl83Ex1vMxrZy0rdpfeDZ84W2s=; b=P
 WddvEGZDcCK1YusBtsTXbymDASRcYyFi6A3BnkDZXlh/PCOR4tgOPWDYRw/o45pXPVpdyc9Swqqhn
 ODx/Ls/Zr/DKzh/z/51pu4GtEZB1oDJXmuaBrYeLQOo3mrPmcPyYWa7aAV9UDft7rVV1mCACCVIV1
 QJm2nPumYfzOtJxQ=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sCrGE-0002gM-Jn for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 31 May 2024 01:40:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id C3FAECE1BC7;
 Fri, 31 May 2024 01:40:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF700C32786;
 Fri, 31 May 2024 01:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1717119637;
 bh=0WiDT1dGqe6HLg8ECHXxrFXdMneyruLAuunh6SvtXoo=;
 h=From:To:Cc:Subject:Date:From;
 b=j6mfJjtMgQ2sacn3i6yUxlICdW+jIvxZoYSiqrG9cOLwWbbtaD581Vni4iHvyfswF
 x+L8wgqVN7i7hI52LhgFoLIKT1o5tPm9Hx/XCRPP8t/x08eJeR9RQWFzUfJv3Jkz2o
 TRTeLqzTTtbVDDQ4LAQ8WQ9+qrROI29EuA5TvBFPULuNQd3rJxS0VjI/k+hhpvNmuQ
 kdhb08hq6SEHOOEcSzVF7yzW+Y1eMpxBF3jpb3hoBnQ6FKgj7Ywchgglpp9OAICt/7
 VngL6kjJWjluZrTUUZ2CajQi/CJlnJrXVKs/gzzy149MYmVbXSyVH+zI3dx8GS3TKO
 cEWjlcf4WJ1eQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Fri, 31 May 2024 09:40:28 +0800
Message-Id: <20240531014028.1014251-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1sCrGE-0002gM-Jn
Subject: [f2fs-dev] [PATCH] dump.f2fs: update dump_usage() for directory
 dumping
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
Cc: Daniel Rosenberg <drosen@google.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Add missing usage for directory dumping functionality of dump.f2fs
as below:

  -r dump out from the root inode
  -f do not prompt before dumping
  -y alias for -f
  -o dump inodes to the given path
  -P preserve mode/owner/group for dumped inode

Cc: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fsck/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fsck/main.c b/fsck/main.c
index 6edc902..c13e287 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -97,6 +97,11 @@ void dump_usage()
 	MSG(0, "  -S sparse_mode\n");
 	MSG(0, "  -a [SSA dump segno from #1~#2 (decimal), for all 0~-1]\n");
 	MSG(0, "  -b blk_addr (in 4KB)\n");
+	MSG(0, "  -r dump out from the root inode\n");
+	MSG(0, "  -f do not prompt before dumping\n");
+	MSG(0, "  -y alias for -f\n");
+	MSG(0, "  -o dump inodes to the given path\n");
+	MSG(0, "  -P preserve mode/owner/group for dumped inode\n");
 	MSG(0, "  -V print the version number and exit\n");
 
 	exit(1);
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
