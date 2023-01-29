Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722E2C05027
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 29 Jan 2023 10:31:12 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pM4xs-00067K-Ca;
	Sun, 29 Jan 2023 10:31:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pM4xp-00066x-5s
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 29 Jan 2023 10:31:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d+2rBMaIpjCoNoUR7mxGyYyFw4lYnjuqHU+uIQgjTzs=; b=IILXwpO9yTtZCxBAJj+UFpJNOS
 0KFMJTuXBCPeyzYSf+yBwRexVUnwBvr62+BV1/4f6eourDnDqGuUF9/V2j7fGw0leEcflMB2hLewC
 dgyIMkrEb0vLdBmEfTsaOeyRx/ttQ5gQbYgaqUSKmsphMralctfFeVOUYqa+G19JUVq8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=d+2rBMaIpjCoNoUR7mxGyYyFw4lYnjuqHU+uIQgjTzs=; b=lJKt6Ro+bPrGbqUESV3ZNrmWrX
 xURvIlssUOTyUf3QIUg+NwHLFRhcU4MAPkBoT2psxauMGU6JLaqt89DsURZogj/cdx/Hb5I0ik7S5
 ChYOfOcT72znlVJ4/7JX86r7G3Z/k6RpMU48aSonW7Q0mTCEQxUfhajw20i2pLJffXGc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pM4xn-0006lo-35 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 29 Jan 2023 10:31:08 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A565E60C81;
 Sun, 29 Jan 2023 10:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFBBC4339B;
 Sun, 29 Jan 2023 10:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1674988261;
 bh=X0HTR1Tbvj+8TAbRxW0A7UHVEk/wyWjoJignajqcxz4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MtzJiFuauEV71bBhYSlw3i1VfIWksJuUU/Wo110i8+ck8obuOyKViBvVzTKRoMRc0
 8k6AjOLbwM0gEyyrAtyQQKYTM+sY3KeY4gP+dMHmHTux/NRMadG/M0nm6eSCdsgXOP
 +l0oAtlNHaLbUBBjBIGa8X433HmsHETqoNtlUD6gOvrY3LC7r34VIXylDmmbpzrnah
 Wj4BUWsFgjkqlhttt9fw15K28pJP2RbQ70SgUub2YcOnaNPa/50Evj82N3x+NdDN0/
 hmkTTmOpUmarYpyBzamy8VeXCkor7IBaF2t3KsFdBZcah/Npaoa4jykz78itlo4hWY
 OqqhmFQPdE98g==
Message-ID: <27a0d534-564e-5864-d66d-b378882d0cf2@kernel.org>
Date: Sun, 29 Jan 2023 18:30:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20230119063625.466485-1-hch@lst.de>
 <20230119063625.466485-3-hch@lst.de>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230119063625.466485-3-hch@lst.de>
X-Headers-End: 1pM4xn-0006lo-35
Subject: Re: [f2fs-dev] [PATCH 2/8] f2fs: simplify do_checkpoint
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/1/19 14:36, Christoph Hellwig wrote:
> For each loop add a local curseg_info pointer insted of looking it up
> for each of the three fields.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
