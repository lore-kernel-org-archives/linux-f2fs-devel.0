Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CF4C46467
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Jan 2023 13:31:07 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pFbC7-00080T-Ra;
	Wed, 11 Jan 2023 13:31:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pFbC5-00080N-P0
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Jan 2023 13:31:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qr9pYB2VWIIzvrDlzhJZwoGhpz8ozCcA4Sf/TUh3dII=; b=Q73/J/QbI+Nl8oeoLZ1JewtHjl
 226dhsNplyLfc4ZALD2KNk06F8zW2GgpdYDKEWwtLK7sGn3JzajKxy5vyr9upIBWUsv9ib3TxiW8j
 09ODbsoPhIQyrIMt8TAzkp31QN21oBtfvc74WGiBuUSMAKEFfQh+75RblGMMnwM8mbkI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qr9pYB2VWIIzvrDlzhJZwoGhpz8ozCcA4Sf/TUh3dII=; b=E4184Zph/oyz46sZSmIu2r7kCx
 aRd3DwGcuy0AdwEd83zSqdWp0ZS544vYlAC6bZoOLE+eMkpNx/8OCrA9gqPcOmpdohHpMKnhsM1cz
 7uoM9t+Z2Jg3A5rLryij3r3eFRrfvUZx8hlczmg3r+an1VdRPTbyPFUT+1TMd7IVZyco=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pFbC3-0003xC-Qz for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Jan 2023 13:31:04 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6A47161AFE;
 Wed, 11 Jan 2023 13:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E321DC433EF;
 Wed, 11 Jan 2023 13:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673443857;
 bh=QSRDEhjQOIo+1Nf6WjkaaVUOZYxoWbLk6Ng5D63wRtk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=oZiIJdF6H8ADKwN3l2+goyFyMDs29JZDKum+lywwyA8Oj2xnomUR/PyFk/eT6DXKl
 P8YYzAkKiSgXhgHLlC03Rwrl7Z36MP6RvWFDjwB8J9NnFBOgePLTw5Q7mHtphMomvo
 mmIl2OkjFzGS2WQzLBs6GoOKYMfQpF+xuY7LSyC6QQgjd+Z1U19nPV3T/1iwfd5+kj
 X+vZSdMmPCwU4zPHQKrUBMvufd0M6QwhgokNPR6d1rpClVPxleHLLZDnPWRjR/mutD
 w8p8cwt6N4vc5C8zpCMWS+CGrM1NzegJaSjvn24oke3G6snbbdIzmAk5klds/RVaaE
 i3KPExJbosgvg==
Message-ID: <8d71e53b-3ca0-3c84-acf0-5e8ec0952cc3@kernel.org>
Date: Wed, 11 Jan 2023 21:30:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
References: <20221220183904.53908-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221220183904.53908-1-frank.li@vivo.com>
X-Headers-End: 1pFbC3-0003xC-Qz
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: merge f2fs_show_injection_info()
 into time_to_inject()
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

On 2022/12/21 2:39, Yangtao Li wrote:
> There is no need to additionally use f2fs_show_injection_info()
> to output information. Concatenate time_to_inject() and
> __time_to_inject() via a macro. In the new __time_to_inject()
> function, pass in the caller function name and parent function.
> 
> In this way, we no longer need the f2fs_show_injection_info() function,
> and let's remove it.
> 
> Suggested-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
