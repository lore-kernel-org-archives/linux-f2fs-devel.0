Return-Path: <SRS0=qkV1=JJ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF33C433ED
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Apr 2021 13:14:12 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF10961288
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Apr 2021 13:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF10961288
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lVwOI-0008CZ-5N; Mon, 12 Apr 2021 13:14:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <changfengnan@vivo.com>) id 1lVwOG-0008CR-NK
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 12 Apr 2021 13:14:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g7OhgQPE3iWB+ZCrgliKr4Bsug/3/Dadv/dUuczm0fc=; b=l4jFYF0kKfwW+nfW4msCRPTOmb
 uzT7Di5LcSScTzqx5OG1jz/mzZHZ9x7fd4ZhIpXmyrIARi05xA8zjLAY4z8S6qw8VGxXJBC4La7j0
 Hi8EunindEYNmh4WTC4+vRoZMDRoMRVVIZbNqTCNQXeFqss61AfJ4+Ohj4L9lp5RmVzk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=g7OhgQPE3iWB+ZCrgliKr4Bsug/3/Dadv/dUuczm0fc=; b=l
 EiKGIziHFfza6yLhCpzvSFMDxMGjBTzDcbA9zxcPUiN6cA2S0hfXtqvd1k7bOW540hcGZzoEAqQWD
 N+FH0EEGP4z8waGyIt3F+Duco0xC+k4J811MPvuv7EncYxEMe7qfta4A3YxSM+ZMjGzfOWTYQOiMQ
 YERK/4U1D46/1ibY=;
Received: from mail-m118208.qiye.163.com ([115.236.118.208])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lVwOC-0007Uj-V2
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 12 Apr 2021 13:14:08 +0000
Received: from SZ-11126892.vivo.xyz (unknown [58.251.74.232])
 by mail-m118208.qiye.163.com (Hmail) with ESMTPA id 09AEEE0355;
 Mon, 12 Apr 2021 21:13:58 +0800 (CST)
From: Fengnan Chang <changfengnan@vivo.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Mon, 12 Apr 2021 21:13:57 +0800
Message-Id: <20210412131357.368-1-changfengnan@vivo.com>
X-Mailer: git-send-email 2.29.2.windows.2
MIME-Version: 1.0
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
 oVCBIfWUFZQx4ZTlZMSRpKSU8eSB4YSElVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKSk
 NITVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pz46Ayo5Kj8TPB89NChIExoM
 HgsaCzVVSlVKTUpDSUhISUhDT09IVTMWGhIXVRgTGhUcHR4VHBUaFTsNEg0UVRgUFkVZV1kSC1lB
 WU5DVUlOSlVMT1VJSElZV1kIAVlBSU5MTjcG
X-HM-Tid: 0a78c637a27a2c17kusn09aeee0355
X-Headers-End: 1lVwOC-0007Uj-V2
Subject: [f2fs-dev] [f2fs-devel] Why does f2fs not reduce disk space when
 compression is on?
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

I'm testing the f2fs data compression feature. I created a new FS with the flags extra_attr and compression,
use chattr -R +c on the test dir to enable compression for the directory. 
I found that when compression was turned on, the files did not take up any less space.
Using trace, I see that the data is indeed compressed.
Is there a mistake in my testing method, or is this how it was designed and why?

This is my test method:

# mount
/dev/nvme0n1 on /mnt type f2fs (rw,lazytime,relatime,background_gc=on,discard,no_heap,user_xattr,inline_xattr,acl,inline_data,inline_dentry,flush_merge,extent_cache,mode=adaptive,active_logs=6,alloc_mode=reuse,fsync_mode=posix,compress_algorithm=lz4,compress_log_size=2)
# df 
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/root               114901    112444         0 100% /
devtmpfs                497436         0    497436   0% /dev
tmpfs                   500060         0    500060   0% /dev/shm
tmpfs                   500060        52    500008   0% /tmp
tmpfs                   500060        20    500040   0% /run
/dev/nvme0n1          10483712    499724   9983988   5% /mnt
# mkdir test
# chattr -R +c test/
# dd if=/dev/zero of=/mnt/test/file bs=1M count=100
# sync
# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/root               114901    112444         0 100% /
devtmpfs                497436         0    497436   0% /dev
tmpfs                   500060         0    500060   0% /dev/shm
tmpfs                   500060       368    499692   0% /tmp
tmpfs                   500060        20    500040   0% /run
/dev/nvme0n1          10483712    602232   9881480   6% /mnt


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
