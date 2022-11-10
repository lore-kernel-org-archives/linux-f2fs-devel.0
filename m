Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B04C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Nov 2022 11:59:46 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ot6Dg-0004wQ-3P;
	Thu, 10 Nov 2022 11:59:44 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ot6De-0004wK-Jc
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Nov 2022 11:59:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iU+AWyHVFTvuQ6DBJdVNpVWzCaRXgnGoIv8XO1pnBds=; b=X6I/JRCYZfJDv/sB4KceJZ/gxO
 C/gOkkxuWnQW2L34l/l4GTgKjV8h7Pu4sR9wUBB6uQ+f6mvbLVwR/EEmYqZpCC+XcXvSB/Aa51SXz
 PF16hJnnYzNvBbTo0HwsAwFjoUQpNZHFTTAN39Vk+4JUeiAXtOFAuTyfF7SiJ58QStNE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iU+AWyHVFTvuQ6DBJdVNpVWzCaRXgnGoIv8XO1pnBds=; b=OmNHA/lRyjccUSVJyqY3yswTU6
 1J1OrrpMYnicshtoIW6SzVcbZimAWuaNncEvZN96Twyc4sERHXZ31gWT50MuOadfHDVU1sqf1csiu
 3S/h63xZvG+cH1Fx11rgnBKQuAmzlZlA/dPc463OdM4W0FAq1tVJUwZkd12MQ1YjLUy4=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ot6Da-0000We-Dj for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Nov 2022 11:59:42 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id DB75DB820D0;
 Thu, 10 Nov 2022 11:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC02C433C1;
 Thu, 10 Nov 2022 11:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1668081567;
 bh=ifwpGaqjD523D69w/tpepT0NSWLGNe1JlDCyN9ZF2f0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=C5fQpkaLsxTg+efYnEcXRNCJNAiqv+iYdR8ZCHQ90G3s9AKIDZyppi7THNA24noXD
 Dh9GK1935ulSRcvZWkcn1zDIjBPWwiqt1Y5jI7hSiJ9/mdn6bf/Hmh8FxPUz7M3R0f
 X07exI3DF2nFFHIPVElilH7SlmUC10z7AnCT1acYfN3drKV6RNDiiz5yyvkcH4OxJq
 sXXHI/hLCtSQ4/XpoU3n7AkHElUbm0GhMLhZDEVQtUBkyAlN+9MicpNHXJe7aALDX9
 xN9zD+sdCoHXJWShqsbhqZ41JgQ/ccwfzZ/OVHJGTKilTeoIw2ZdoMAN7byTv/XOKP
 8s3y1nATebtgQ==
Message-ID: <83950f6c-4ba3-7e50-5fa4-c895e452f0fa@kernel.org>
Date: Thu, 10 Nov 2022 19:59:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
References: <0000000000007edb6605ecbb6442@google.com>
 <0000000000006a83e705ecea7171@google.com>
 <d8aec8b1-4982-fc06-fd30-0b9a4b4fc4b9@I-love.SAKURA.ne.jp>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <d8aec8b1-4982-fc06-fd30-0b9a4b4fc4b9@I-love.SAKURA.ne.jp>
X-Headers-End: 1ot6Da-0000We-Dj
Subject: Re: [f2fs-dev] [PATCH] f2fs: initialize locks earlier in
 f2fs_fill_super()
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
Cc: syzbot <syzbot+40642be9b7e0bb28e0df@syzkaller.appspotmail.com>,
 terrelln@fb.com, syzkaller-bugs@googlegroups.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/11/9 6:04, Tetsuo Handa wrote:
> syzbot is reporting lockdep warning at f2fs_handle_error() [1], for
> spin_lock(&sbi->error_lock) is called before spin_lock_init() is called.
> For safe locking in error handling, move initialization of locks (and
> obvious structures) in f2fs_fill_super() to immediately after memory
> allocation.
> 
> Link: https://syzkaller.appspot.com/bug?extid=40642be9b7e0bb28e0df [1]
> Reported-by: syzbot <syzbot+40642be9b7e0bb28e0df@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Tested-by: syzbot <syzbot+40642be9b7e0bb28e0df@syzkaller.appspotmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
