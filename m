Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E76CD37AC
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 17 May 2026 09:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sPCb2xkk92nj7FtZ7YexK+itr0YwQMjkG4nlkQsO+SI=; b=Z4UgajvTwBxHKK1FIvlafbim4b
	xxwweY295j5S810fJG/quzPLZVSixpKAvJ3x9Rmk2H3gn81AijFSqHJmOEg8RmejKR5FLVxKbJEhW
	XkvbMy7RNsimJAaf+B43r8dkLveO1l4V2BE1V3hL5glWcTQG8/TM2IUF8FGixI1ZPhO4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wOXhz-0004Ja-Rx;
	Sun, 17 May 2026 09:22:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wOXhy-0004JR-PM
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 17 May 2026 09:22:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WjYkvB4Trgl3NVprcjVx5OY/NUPXlI7DCyeCFMhw7lQ=; b=PvcW/07/aSMesIPwPu8UdojAPJ
 aJRN+Qm/aGUSA0xvlY8OYbsvSaXwxpfhIpvgUj0UdHTHkQSGnTJxdrc6DgJjzj4c4Q3Om7NH+m6Fm
 YNTnUMJ3iOoY+tYDOU9HfneabKn9DiZWhrATUdgodlVDUqiLtrd+eVVjZsbRsheG8r7E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WjYkvB4Trgl3NVprcjVx5OY/NUPXlI7DCyeCFMhw7lQ=; b=idZAVd7VJf0v3kOBT4Vpb1CWdK
 VU4sWmtnkYC/BELiv9jy8gYOckxz0gtuzk2YHOthBLBYPlKpX5s62wdX2fBAVIJme52r7kZ//JcCR
 ZxJofj7dkuH7GGwPaRTsvGs8BGrbLkjbzASJnZ4fFg399hRKUBFLBIR1Grqwx/rfd/fc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wOXhx-0002m9-Fl for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 17 May 2026 09:22:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 503B8600BB;
 Sun, 17 May 2026 09:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D9BC2BCB0;
 Sun, 17 May 2026 09:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779009759;
 bh=H6zhr3xk4A26fUQCwZKYKnFd3vXmTj0GWYGio1zPhS0=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=m8Gf93TRicmHJ9ANzzOQZMPBShClFEw/HC+w/Eo90yC6JYkDgVlTGtPsaHAHlRzNQ
 Bs5P+Rg4pYRvAntJNW++jq+XMBps/Om/JWg6EPXBAiWlGjWm6I5tDEvmaehwBhodIU
 0bBAUFEXJmkt4VDRoXJq67Vu9e/GticPL6ToLkvW+zCT95UIHTHtfFs87D2NvGLaGu
 Udmh7nUtrRnX+CopNGJtMSOO++caK6CkhknX7ARbyYrDm3mTAdIV9gIX3of8oKseBD
 PneUaw3DkuPjvVluSbXdg+BveeAdhspTd6GwvobuYkGJByMU85fbAu1EqExDN2YTeL
 oyFFzrwiBA8Tg==
Message-ID: <993c9fcd-d21e-43ab-8c1b-d66bdb2b7500@kernel.org>
Date: Sun, 17 May 2026 17:22:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: liujinbao1 <jinbaoliu365@gmail.com>, jaegeuk@kernel.org
References: <20260513141436.1278665-1-jinbaoliu365@gmail.com>
Content-Language: en-US
In-Reply-To: <20260513141436.1278665-1-jinbaoliu365@gmail.com>
X-Headers-End: 1wOXhx-0002m9-Fl
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: add iostat latency tracking for
 direct IO
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: shengyong1 <shengyong1@xiaomi.com>, liujinbao1 <liujinbao1@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/13/2026 10:14 PM, liujinbao1 wrote:
> From: liujinbao1 <liujinbao1@xiaomi.com>
> 
> F2FS did not collect iostat latency for direct IO reads and writes,
> hook iomap_dio_ops.submit_io to bind an iostat context and record the
> submission timestamp. Replace bi_end_io with f2fs_dio_end_bio() to
> collect IO latency on completion before calling back to the original
> iomap_dio_bio_end_io(), to add iostat latency tracking support for
> F2FS DIO.
> 
> Signed-off-by: shengyong1 <shengyong1@xiaomi.com>
> Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
