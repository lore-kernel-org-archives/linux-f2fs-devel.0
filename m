Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B078CD8CB2
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zjYRZDO/B+SPfvT42fY3LN77+Gluy7JThXiLyXUSq10=; b=AqutH6I9puxSZBklO0PKAbyVGK
	WH/RXxgj3Sy5FpizE+DqhHH7ZcAm36fjWYI0/w0kn4K3vrM6yqKkeoysHY1/1y4JSpD+vZ3eYeiXs
	Fj9GGo2O6tuUseF2oH7wNFa5oZ1O28rPtEYTWr+L3jGx39rgYf9+rzSRJvvjTC9P+dmw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wXHmB-0003kP-Ew;
	Wed, 10 Jun 2026 12:11:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wXHm2-0003kD-Sn
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 12:11:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xFUNOmeXm0vZ2kd4BCuEER2uLa+UFlZyy1a2dD+3YOk=; b=ZhEN44agnY8nOtKsXP+6FbzqBn
 63/bupC5G156am1vui+doiPrKomPo7QJiJTSx0lnTU6c8/YNNm07DPpKTTCiEbSK/B/CNzMTrHMGI
 Rugs+oXAMtGoOmr475WuTFbfOVXkNhZtZ3r3YUNkld9GlNjpRm3zlQT788ZhTl9jiA6s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xFUNOmeXm0vZ2kd4BCuEER2uLa+UFlZyy1a2dD+3YOk=; b=Hi8zRxa/Fra+IAZhBD8+p+TZVI
 AeInrVfKzjxO7f5JfMZSk3HmzKtC2vcjd6oQHYyETsSp+An7Qt6ToAdXJ1P2gi/gSQLE6TnoEiMUg
 TCswmbdk0WHVMKtyyUPeC6G4peUPqGbBnbcVdiGLnRWIBHNWNA59JRamFjtK8ceULshg=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wXHlw-0004OB-95 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 12:11:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 231946020A;
 Wed, 10 Jun 2026 12:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB371F00893;
 Wed, 10 Jun 2026 12:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781093453;
 bh=xFUNOmeXm0vZ2kd4BCuEER2uLa+UFlZyy1a2dD+3YOk=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=m5wgDIKF5CkY5wtZnVmjw1gF+sBBfF7uwQzaSOoSuaZOvHES1CzpSmpeNN0hYcZHv
 Rb8eJuoP1GBvImEjnbYwl53WA5uoMmK2oPuMFC1c0bVQz40hTJYDSfs56LakqM4NiW
 Vjv020KlQ87RIVGsjz8NY+gqNgtKBrMttQ2dNW5PYK3ON5RL/GQfGt8dYNK+89lEjB
 l6j/lgcAtCgEz99brAGWCswETJ5iuZolKP9RkvlQx1pjWbUIHJ4oqECIDlCHs4sM/q
 ZSOObS2l/fjgPwLSlF4owMP5Oms3WGQg7BauKw+DiNClCo9JyL0GB/UfNwFqczq4yr
 FLg5d19dQqpBw==
Message-ID: <a7f2d625-07f0-444f-b6a4-2c9cc86bac9e@kernel.org>
Date: Wed, 10 Jun 2026 20:10:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Bart Van Assche <bvanassche@acm.org>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <cover.1780003055.git.bvanassche@acm.org>
 <b2addb590d05b91a724382bdf94d2e4bc9797982.1780003055.git.bvanassche@acm.org>
Content-Language: en-US
In-Reply-To: <b2addb590d05b91a724382bdf94d2e4bc9797982.1780003055.git.bvanassche@acm.org>
X-Headers-End: 1wXHlw-0004OB-95
Subject: Re: [f2fs-dev] [PATCH 2/4] f2fs: Rename f2fs_post_read_wq into
 f2fs_wq
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/29/26 05:20, Bart Van Assche wrote:
> Rename f2fs_post_read_wq into f2fs_wq. Create it unconditionally.
> Prepare for using this workqueue for completing write bios.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
