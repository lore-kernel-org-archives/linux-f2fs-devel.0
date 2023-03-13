Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F26C61DA4
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 13 Mar 2023 06:11:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pbbP4-0003b5-QV;
	Mon, 13 Mar 2023 06:11:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pbbP3-0003az-Bm
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Mar 2023 06:11:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fwdL36lyRy5X2Xrqjo9oTL7oPzkfWYn0zbDfnO3ebbA=; b=NSCUGT9OU045DTYVXCEOYlUFBR
 N33T5mgeczcF3ejGEJnFdAIvLwmhy0D5APGoD99dLFPGgOSeof4QE2BsFg18PTATXKI5CVR4EIP+K
 w94vUgpXsBX9gzhyWvJAsdw8UfVZ1Ri9NdtWf1lga1avaZx/z1DYgaynkOfSLiZQqje0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fwdL36lyRy5X2Xrqjo9oTL7oPzkfWYn0zbDfnO3ebbA=; b=Qpw1zzi2CclzXJOV+cXOhZeiDW
 7x8IsZaMUoaaOp/vh10b9iJqi6o/FV8+urlEVoywFwYIVqdYbW3rJsMCmqqyLWvjK90906Sp7bi3H
 B61kccr+UDnGk56NJJCj6eV3ta1+/uhchvjfqzS+IHGJURv0fNrlCaJcHpZs+TT9QKyw=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pbbP0-0003HL-3a for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Mar 2023 06:11:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id C5963B80DC9;
 Mon, 13 Mar 2023 06:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA3CC433EF;
 Mon, 13 Mar 2023 06:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1678687874;
 bh=M71ZgoxDEaJTFCv9qREabe0T9N5RycER19GdQFWzbI8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=beUYWcxOBI/bMBoLACq41rtJTHvWko0t1YY2YLj5gj4hMpx36WEov3F/6ZlzOT3p/
 evNnrbDADol2psYbO2lGfHx51GMtZ81Osx1LkAp40397Ejt/anxzF4G5R+dKpHa9cs
 zZv1lDXDJFytXGksVcuJrdiGMa/rIbVviQ0uPko2OqUid7faTQx06L+wDSHRwEmeib
 K/TUtUYo0u9O33eE8iG7OlCX3j9CrEGe3wMMlK8+iIVrNfBitjiCoXF4zN4HijadBy
 W4ougqdYUT54M6Qlk6k1MDdU70sdBsSh+QUgpQNckKPo0eA2WFxYc+Rzr8wsnkm7X0
 r66H8IJfJ5OrQ==
Message-ID: <67687aed-df8e-4264-57fd-f19dcc36ae10@kernel.org>
Date: Mon, 13 Mar 2023 14:11:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, Yonggil Song <yonggil.song@samsung.com>
References: <CGME20230215024850epcms2p22be2cc864d82b44f31c19a7ef28770b6@epcms2p7>
 <20230216071350epcms2p7b3f5f37b168b634ec7a7ba8555fd0b49@epcms2p7>
 <ZAZgf4sbh14sVZMp@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZAZgf4sbh14sVZMp@google.com>
X-Headers-End: 1pbbP0-0003HL-3a
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix uninitialized skipped_gc_rwsem
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
Cc: Seokhwan Kim <sukka.kim@samsung.com>,
 "daehojeong@google.com" <daehojeong@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/3/7 5:51, Jaegeuk Kim wrote:

> Applied with the below fix.
> 
> Fixes: 6f8d4455060d ("f2fs: avoid fi->i_gc_rwsem[WRITE] lock in f2fs_gc"

')' was missed.

> 
>> Signed-off-by: Yonggil Song <yonggil.song@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
