Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC54CEE01FA
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Sep 2024 02:11:54 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1soCpm-0000iA-5S;
	Wed, 11 Sep 2024 02:11:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1soCpk-0000hv-HT
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Sep 2024 02:11:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P1VFn7dwTHuzEsz9ICNU2+DgWUdXkia+oLvb3NPPcWk=; b=ebTGgU1qHuNYmoMda+6AM/Vqz9
 JVjrTMR1WkjEmR/6Zj9PxxIpbILX+ha37YFl6A6ezf0d9u4tyT3+Z747ZecMaLTcGfZxD+Ym8YlYS
 8j+i8txDX4vGwvU++Fwrabp7/VmiikwpNf6G/kRRUB+qgo1VR8SVHBKOaYsIkiPxtq34=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=P1VFn7dwTHuzEsz9ICNU2+DgWUdXkia+oLvb3NPPcWk=; b=cPFA8jX8okABGlCsXBALbR1fJE
 hwLrAN2FwiPXiweIgthaHiEk54J52S49wqoAlXXPJxGM35eKWCVKHqUxqw3ed2C2vKI7UT2y8smUe
 imr2J5m9IsU/wTJPTTo1CXoAmCcT/8Swn8Z9g8q/wgWZvBdqfOZpoI8eNW1ec88/h1bc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1soCpj-0004qZ-VG for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Sep 2024 02:11:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 06B055C02E6;
 Wed, 11 Sep 2024 02:11:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E37C4CEC3;
 Wed, 11 Sep 2024 02:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726020701;
 bh=1mJdaCMQ/y+9vZRgUVNXZFTQ16s9zRPE93MsE9D4JL8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=S10nq36gUFpRFz3NpLdrRMYVvlcP/anrrOBUYn3SJTrfQDFMdjUQax/lY+8fTF7NE
 wpk0hItcbiw+qZv7WuNqwxdxK6nNARI+R4QkAimP5bEJGGLjLaSg/cCCT+bWm+B/N7
 fBLzre7IeZyPBxBXsNqWgEwi5/loELUswEw12RQl2fy0E1ciF3nlrLaN0LWiMLp/oY
 Pn6Cq56b0NDM3JxNb3wxVSg8z4G79fRyf5UNbo+W2cz7ucFbQDpwHlIjkaplFiIPHx
 TyEAYOLpwxWC69D9QVQ674aF8H2EhmcQDvRogVRhgqFyxAAabhMZ8XYKosvXBrFvJF
 4LWJpuYDdVA5g==
Message-ID: <31db09a9-cd34-431b-8e16-31b06785430a@kernel.org>
Date: Wed, 11 Sep 2024 10:11:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20240909221946.2004046-1-daeho43@gmail.com>
 <20240909221946.2004046-2-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20240909221946.2004046-2-daeho43@gmail.com>
X-Headers-End: 1soCpj-0004qZ-VG
Subject: Re: [f2fs-dev] [PATCH v2 2/7] f2fs: introduce
 migration_window_granularity
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/9/10 6:19, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We can control the scanning window granularity for GC migration. For
> more frequent scanning and GC on zoned devices, we need a fine grained
> control knob for it.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
