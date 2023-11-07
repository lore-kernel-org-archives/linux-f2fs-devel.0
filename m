Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF7DC4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Nov 2023 14:17:07 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1r0Mt8-0002Lc-Jy;
	Tue, 07 Nov 2023 14:17:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1r0Mt7-0002LW-P1
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Nov 2023 14:17:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LmijQCUnmJqnCZUoN86tnZJ3W+CuAs+D0O3kpZGHTdU=; b=RWD/LmfEw2WSwgSeJSOS+REg0f
 V3WOBq4swtKFnL4MRggWgouJGduYT+KtcdF0Iwoz4jXJumzGdkZ1vEjqIECZ/cS9OkTTp5PdxNZ1T
 Fxo+XcWN5aA8bmhye75XAm1FgnEGohMNv73E3jZr3GDiIht3c1KISYXy3iigi/ShkUoo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LmijQCUnmJqnCZUoN86tnZJ3W+CuAs+D0O3kpZGHTdU=; b=ldEglrjBKVYVUp+HaFEamNBnw9
 2MiTtyx0nHXzwyx/vF6eV+/RC6yhWO0p3400LM4F2KmWLTNi3T29tTA8Ov8v+mjWAk4lYIQo/E9JR
 DSeHozrl20/Pcj/mj+gqMkzwXZah5QHteuwEOh9gilhfRJcMuH056t0P5E5AREihrLlk=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1r0Mt7-0001jV-22 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Nov 2023 14:17:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 7E6C0CE0E9F;
 Tue,  7 Nov 2023 14:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7161EC433C8;
 Tue,  7 Nov 2023 14:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1699366617;
 bh=R9OA8mhF5RghtqDJjribVRkp7fFko3YunNCGXQmTRBk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=HfkY3eYpgEsTR5dXAgY2XDtrW1QNCGxNKiRZWC2JIGrzN2mcsnitFAjyqEca46oeG
 IZG8hahZEf6lti9KywdC5+yelpLHThmga18uhCh062gapZqclRp98mOeLVsrQlQz5K
 JTZpZ/xtgvB0bXykGOtnbsY3ksz1gdFAz0H5D2k0et76qwlXLUodWbZVnq0bzrJMm1
 bOx0/blFr7Dk0SA668opAG/9F7YEaJ6RJiVgjL9TzVJTylpofgDgY6yFoFfPee5jz7
 qCheczoAkyI3TJuVuthpyRwE0u79UDYviTv4nCKmLdVmeRTM1qWHkktGSA+GKe7s7+
 Wbo7Nx8YwxV0g==
Message-ID: <46d5e083-6e85-1e92-8123-3d0c7579c79f@kernel.org>
Date: Tue, 7 Nov 2023 22:16:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: zhangxirui <xirui.zhang@vivo.com>, jaegeuk@kernel.org
References: <20231021121907.2908801-1-xirui.zhang@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20231021121907.2908801-1-xirui.zhang@vivo.com>
X-Headers-End: 1r0Mt7-0001jV-22
Subject: Re: [f2fs-dev] [PATCH] f2fs: use inode_lock_shared instead of
 inode_lock in f2fs_seek_block()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/10/21 20:19, zhangxirui wrote:
> inode_lock_shared() -> down_read(&inode->i_rwsem)
>         inode_lock() -> down_write(&inode->i_rwsem)
> 
> Inode is not updated in f2fs_seek_block(), so there is no need
> to hold write lock, use read lock for more efficiency.
> 
> Signed-off-by: zhangxirui <xirui.zhang@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
