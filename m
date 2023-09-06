Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA679EE14C1
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  6 Sep 2023 18:03:14 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qdwrw-0006lS-4w;
	Wed, 06 Sep 2023 18:03:13 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
 id 1qdsm2-0003Qh-8J for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 06 Sep 2023 13:40:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9xLIXBFk9eTN9ISTG9m8T8JpcSRP3pSRLMt14B9lx+M=; b=IlX8UUy3CPbMXY9U0KvGxA8HbQ
 RcdWeuSycXUSIn2zLIK+QYfHfijLje8YJHQ6G9bllwfZNaX3CzrNGHNDuCwwy63L30VbL/2e8MiFu
 8I4YsEYwk4zarSobEVtsYEhcnQJy62rGdkUVIaORTwhGHu093j+fbPDGZokzhoYd7360=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9xLIXBFk9eTN9ISTG9m8T8JpcSRP3pSRLMt14B9lx+M=; b=Yr5RdTNcBhL7hV0aD/gDqjJL7L
 iYOM4Gt7sBJcpGPJytpBQTIME55hxxKWZqLIkPRA0g/BOQfDz0XgUhIP0bx4crDWlb5Uf0b7DsRq7
 svQAlxAr2wub992tJF8JaHOdFI5l1pjTpKQhh/M4gjOuONF/jn5cegXdrkqg/KAFbOi8=;
Received: from www262.sakura.ne.jp ([202.181.97.72])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qdslx-00BIcA-9K for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 06 Sep 2023 13:40:51 +0000
Received: from fsav120.sakura.ne.jp (fsav120.sakura.ne.jp [27.133.134.247])
 by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 386Cu4e3090843;
 Wed, 6 Sep 2023 21:56:04 +0900 (JST)
 (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav120.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp);
 Wed, 06 Sep 2023 21:56:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
 (authenticated bits=0)
 by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 386Cu3xb090838
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 6 Sep 2023 21:56:04 +0900 (JST)
 (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c4d0bbf2-c4a8-cb2e-e941-a68a15cfb042@I-love.SAKURA.ne.jp>
Date: Wed, 6 Sep 2023 21:56:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To: Lizhi Xu <lizhi.xu@windriver.com>,
 syzbot+a4976ce949df66b1ddf1@syzkaller.appspotmail.com
References: <0000000000000f188605ffdd9cf8@google.com>
 <20230825053732.3098387-1-lizhi.xu@windriver.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20230825053732.3098387-1-lizhi.xu@windriver.com>
X-Headers-End: 1qdslx-00BIcA-9K
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix deadlock in f2f2_add_dentry
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
Cc: syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/08/25 14:37, Lizhi Xu wrote:
> @@ -736,12 +736,12 @@ int f2fs_add_regular_entry(struct inode *dir, const struct f2fs_filename *fname,
>  	f2fs_wait_on_page_writeback(dentry_page, DATA, true, true);
>  
>  	if (inode) {
> -		f2fs_down_write(&F2FS_I(inode)->i_sem);
>  		page = f2fs_init_inode_metadata(inode, dir, fname, NULL);
>  		if (IS_ERR(page)) {
>  			err = PTR_ERR(page);
>  			goto fail;
>  		}
> +		f2fs_down_write(&F2FS_I(inode)->i_sem);
>  	}

Above change does not match below.

fail:
	if (inode)
		f2fs_up_write(&F2FS_I(inode)->i_sem);

>  
>  	make_dentry_ptr_block(NULL, &d, dentry_blk);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
