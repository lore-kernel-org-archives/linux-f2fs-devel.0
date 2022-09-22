Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFDEC54EE9
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Sep 2022 11:53:05 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1obKlL-0006ox-Pk;
	Thu, 22 Sep 2022 11:53:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1obKlK-0006or-Eb
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Sep 2022 11:53:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oA2Dc8CxpyaDZ8OXdlFND9Cg8f51ZJ0amdXlSrhDcmU=; b=hV6YhE6nu7G9rqiLRwtVI2Bp3j
 QOxk7fWI3VN/wEh02dmkH5Ghp4AVomE5Df7QRMjptSHEL6iIgTkiSro4PrmIxMoyyz3bRe8MoG/rW
 Cn7K3P1Tk3gFOkplrx6y3d9CJOa86+PqIbuRgTl5Je848PBBvhiy//MirJh5w3/VBfIk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oA2Dc8CxpyaDZ8OXdlFND9Cg8f51ZJ0amdXlSrhDcmU=; b=Ugbfs7VcH7UZh0QKpciqHmIcSE
 ahZRiS1PRD8fKNw2KtNxv7IGOWJGOQryDzpky/ZNiwSctO9FvEoEJW0xF5U6ufThdeyshL8SdtfRc
 NQo9fCZk2+5ELQZGtZ0EaFA6ViFrFmYcJ0Eh3KEYLSvFfrXeyIR8L7vV9T/q/H4qIL7c=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1obKlJ-00GVHt-QZ for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Sep 2022 11:53:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7351962D42;
 Thu, 22 Sep 2022 11:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA14C433D6;
 Thu, 22 Sep 2022 11:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663847575;
 bh=oA2Dc8CxpyaDZ8OXdlFND9Cg8f51ZJ0amdXlSrhDcmU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jayxvSg33nQzSf/cD6JKxZaMRHcdjGIkTrwNlCLa0iDV2JbEoC6Gn4IFRTekEgyMi
 CauCEKigd9gUsEIVvhWuq/WvfKevwXjdVBlTZRYFHYsmFm1hktfDzHhX9iZTMQrFR5
 sCxwvwxjVErRBHy+jCBK+HnbRXsdvH0ZofiBFj1TqaYsXB7F525wBPu+5slAtQSQxA
 9a6xmsfuXt4TzvRTFXcM4IXUDg/s68pzVjLh9AhDzGWEnKZMjgsFKiY4UfaQ7j2gKD
 iuTgT2P05pOUKYx+LuhI+8kczqIVUBkCg30lTJ2alMDu1q/tonkk87Er+JyEBP4zsV
 wBUW6EVhb8gsg==
Message-ID: <8f311269-1a3e-f662-cdde-27a7e16f94ce@kernel.org>
Date: Thu, 22 Sep 2022 19:52:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
To: zhangqilong <zhangqilong3@huawei.com>,
 "jaegeuk@kernel.org" <jaegeuk@kernel.org>
References: <f61a02d1d93043c193379c584824d159@huawei.com>
 <2bb4527d-6ba2-7e09-531b-021a0f513b18@kernel.org>
 <4f2ac701853d4f89a2ff2a2451ba7695@huawei.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <4f2ac701853d4f89a2ff2a2451ba7695@huawei.com>
X-Headers-End: 1obKlJ-00GVHt-QZ
Subject: Re: [f2fs-dev] =?utf-8?b?562U5aSNOiBSZXBseTogUmVwbHk6IFJlcGx5OiBb?=
 =?utf-8?q?PATCH_-next_2/4=5D_f2fs=3A_extent_cache=3A_support_extent_for_n?=
 =?utf-8?q?o-compressed_file?=
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
Cc: "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/9/22 19:13, Zhangqilong wrote:
> I means it is wrote when being sloaded to f2fs ro image.

sload doesn't trigger concurrent writes.

Thanks


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
