Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF0AC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 11 Mar 2022 07:25:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nSZeg-0000Dv-GM; Fri, 11 Mar 2022 07:25:41 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1nSZef-0000Do-1a
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 11 Mar 2022 07:25:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZETk5eApxFh3gxdQ1xp85jK505HofIIu4oPrYKrOgOg=; b=dPUr+MHjH8CxmSVW32R5p843sH
 1vuMKOPJ3r+omuH27pIYDTcNW+X00pTx7UlbnAWCz9QjOivDknMwaanUrfK8YItM31ocQvR7uz4mN
 NO/ZRdTa+yWNFaP7UDlEyM2A1m0epNT0nDxSwVi0uTzDRF/FbYy/hgL6Tibvq/MNrnJo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZETk5eApxFh3gxdQ1xp85jK505HofIIu4oPrYKrOgOg=; b=FB0Q6XHXNziWwLMH5PDQ0NCRSK
 6nUnYjWC0uD8R6/On00cOho9G+QdWYa0Psr9kVrqH5y0BqW7EkZrYIxtV/U5cCP2SOKPp5svL6Svq
 XIWWpJPMMu9gjGlwaWi8aVtzQa7GExjGXBr4Su1I10VxKXWSd7g5K6nG7aSgAGm+1LKc=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nSZec-0004sD-L1
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 11 Mar 2022 07:25:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 820BCB82AD8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 11 Mar 2022 07:25:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5C8C340E9;
 Fri, 11 Mar 2022 07:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646983529;
 bh=g84WdhT8WlUiVZ4Pe91HKYziG64yo/SO8s//Xpd2fk0=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=RYbR6QstwFDm4TM9v8bCHTbEje2eF314IM+w4i62zCcjy5CbFYtxmMOKpJl1xESrz
 1BCXHnRkodtI0iUZHM1Id/Byrwtcth5mck8sVVve34jt7pFw08XUoAwxdlRGG/xbZs
 bGgog83ItM1AGidvcly4RQhLWGsbx5S5WBDhGI8gTjLDYk4BnFir5Tq35/MNVNkeCB
 MZKdaibOGRjUtHJ23sJKNEOyFufuv+omYan+GeYH1vI8J+HpgUmVsHy3lwtcYSGyly
 XlKLxpYMmGv0fIXnXZ6OMuI4YvbBOwMIkd3EwnqMZLMsMZ1cY1GJ0qdxBsBliotM5X
 x1JAFcmvQVRsg==
Message-ID: <86d59c1d-b453-5ee2-4737-b4dd03829965@kernel.org>
Date: Fri, 11 Mar 2022 15:25:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20220309214834.3408741-1-jaegeuk@kernel.org>
 <Yircgd9d773xnk3+@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <Yircgd9d773xnk3+@google.com>
X-Headers-End: 1nSZec-0004sD-L1
Subject: Re: [f2fs-dev] [PATCH 1/2 v2] f2fs: don't get FREEZE lock in
 f2fs_evict_inode in frozen fs
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/3/11 13:22, Jaegeuk Kim wrote:
> Let's purge inode cache in order to avoid the below deadlock.
> 
> [freeze test]                         shrinkder
> freeze_super
>   - pwercpu_down_write(SB_FREEZE_FS)
>                                         - super_cache_scan
>                                           - down_read(&sb->s_umount)
>                                             - prune_icache_sb
>                                              - dispose_list
>                                               - evict
>                                                - f2fs_evict_inode
> thaw_super
>   - down_write(&sb->s_umount);
>                                                - __percpu_down_read(SB_FREEZE_FS)
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
