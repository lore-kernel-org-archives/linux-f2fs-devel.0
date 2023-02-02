Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93085C61DA4
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  2 Feb 2023 06:13:46 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pNSqv-0001bM-Dw;
	Thu, 02 Feb 2023 06:13:44 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pNSqu-0001bG-DL
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Feb 2023 06:13:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VMOTpIqv7Q3URx4lSVADbdSmKHmtlaHZ/Tr/nSCctyY=; b=kl6I1jMomwso1UPNTWk7QhME/V
 yC9d+vjilNmpEj2MdjCDKTf/5xni87VDtBZfZtwPbwWmhIw33KG5L780/ypde6HbWBQgtToFUAv/7
 bNq6nuUu6SliBKlNX+KRuUEGczf4V5OKnjbRX9z4Vn9oGnYCXpQO5muLTviO2zt0IUlk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VMOTpIqv7Q3URx4lSVADbdSmKHmtlaHZ/Tr/nSCctyY=; b=XYWYbyJCGRaaUJBvm/ZiaoHrk+
 UCYdHRm82D9nazpumiqIZT7EHM3DAUlxpP2wfhPZum4FIFOQlf7aYWyf2sZmlnXmoCavimJD96U0q
 /6McI7oQAjzTdflZoib7HIbdIcowapUxmvADUo4qwEmR9vGrEbzBc+HIizV5MTInjSQ8=;
Received: from [145.40.73.55] (helo=sin.source.kernel.org)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pNSqq-0007ly-4Z for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Feb 2023 06:13:42 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 17D20CE283B;
 Thu,  2 Feb 2023 06:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61EFEC433EF;
 Thu,  2 Feb 2023 06:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675318402;
 bh=Ky/1ghQ0FqtHg3xtb96YzswiIfdF+Rqi4ezcKZbriac=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=oq+IOUsNJsb8KLDC9noPayjVCf2oBUFxMuMDB1bNOoRSDuWLWRHJ3eWvHqXfARpVT
 QBxInPNh415ggQ8QKILcvq7V/ZcAzU3+gThlkmEJeANvWHTJIGDGTWEX5vlN5Gxem3
 Izw2eeLw1PxNKeysXvULTeOFPGUhi1IhSVZ4nJ8fMVj2oTPXhpmd2wbM9418Gzyy3n
 ouKTIP8XDudyWgLTk+aGySOtxVRhLzQM34Xr7UEBFfgQc2/qXLrf/Mhuv9wAomcsBp
 SNSgBCUiGTVU+2AbqmOqZAhCJBpEzPYBYRrGoH9GUz/Tv4NfEwUqHZ/tC6EOHhNHno
 D0ssbfmqouC0Q==
Message-ID: <64d1f9d3-12d8-cc7a-501e-5c0286b0cfa1@kernel.org>
Date: Thu, 2 Feb 2023 14:13:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To: Nathan Chancellor <nathan@kernel.org>, jaegeuk@kernel.org
References: <20230201-f2fs-fix-single-length-bitfields-v1-1-e386f7916b94@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230201-f2fs-fix-single-length-bitfields-v1-1-e386f7916b94@kernel.org>
X-Headers-End: 1pNSqq-0007ly-4Z
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix type of single bit bitfield in
 f2fs_io_info
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
Cc: kernel test robot <lkp@intel.com>, trix@redhat.com, llvm@lists.linux.dev,
 ndesaulniers@google.com, patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/2/2 0:40, Nathan Chancellor wrote:
> Clang warns:
> 
>    ../fs/f2fs/data.c:995:17: error: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Werror,-Wsingle-bit-bitfield-constant-conversion]
>            fio->submitted = 1;
>                           ^ ~
>    ../fs/f2fs/data.c:1011:15: error: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Werror,-Wsingle-bit-bitfield-constant-conversion]
>                            fio->retry = 1;
>                                       ^ ~
> 
>    ../fs/f2fs/segment.c:3320:16: error: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Werror,-Wsingle-bit-bitfield-constant-conversion]
>                    fio->in_list = 1;
>                                 ^ ~
> 
> There is not a bug here because the value of these fields is never
> explicitly compared against (just whether it is zero or non-zero) but
> it is easy to silence the warning by using an unsigned type to allow
> an assignment of 0 or 1 without implicit conversion.

Nathan, thanks a lot for catching this, do you mind letting I merge this fix
into original patch? as the original patch has not been upstreamed yet.

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
