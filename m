Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47BEC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 May 2022 11:22:16 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nreER-0006jn-SB; Thu, 19 May 2022 11:22:14 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1nreEQ-0006jf-Op
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 May 2022 11:22:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6wPm65M/O1lbg4qBPh6yOR18TxyLfPwR6RNdoeh/+dk=; b=fObKKqomYTwJ8Ey/zYzvq/rg7h
 fg+4E6oCuxgzRc7o8H4l58boD92hmHIzFyxLsEWMoIpkb0fotCxL6UeVYhBltEzjV78+QVllSbEEj
 Hk060Ur7wjpu77ATt6TTRl0kMe2SAd5tQ/OK5IBojqUPVNTOtOiEw4mzf6haBPiqmpLY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6wPm65M/O1lbg4qBPh6yOR18TxyLfPwR6RNdoeh/+dk=; b=IRzbhcjhCkAhu1KTWC1Rq+p06k
 ebsRgsGM+3rSZskY/qILojHkJ0j5hgQ8xpd9lzFmbZ0tj/X0QtzQoXOU2WrW98pzkmnCBrS3Nr2rt
 DX4jkaBA0YYSkkvv0pvq6vzlQ0WRZ1x6v6JYq60c7AyVifEi8Cdj34u3W+deGbFIfd5o=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nreEO-00921R-Ds
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 May 2022 11:22:13 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3D4FF61A91;
 Thu, 19 May 2022 11:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9174DC385AA;
 Thu, 19 May 2022 11:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652959321;
 bh=OpQI0301bWKKD5nOghoC8VBmzm7rsdH32HysVf1NgqQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=joaBZKKdAHTEjqvAoAOxSj2x2qw/RlDsQlHgwb8F91MctQyRr5JZQQR4JUh2/WSV/
 +hGhW+wwum9hhtP/yJHdrZIxKRyLJ5qcFqD4b7lKEKOY70hBsVUTDVTHSLkgp/D0SJ
 7hqlcRAW7YVPB83BCvXH5t+HNA50ksFlIeCWCM353Ox2tm3lh0tDVlG3GGXaOiO3wh
 ofWl8To4gJUwGaEJMck4r/4ELsNRb3HGvrte+OIcTLXnGGXwYg7fPwhhm9jlwmE7Lw
 etghlQB/YGn88nMObuYVJx+MPYFhJS0chFB+D+qX2pr7EV4PjPVgcTGRrQ/AflL8MX
 fL4xTvFSDaWlw==
Message-ID: <5c9b94f4-28f4-9f3c-8cc7-b0b09270b91a@kernel.org>
Date: Thu, 19 May 2022 19:21:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To: Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20220513231605.175121-1-ebiggers@kernel.org>
 <20220513231605.175121-5-ebiggers@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220513231605.175121-5-ebiggers@kernel.org>
X-Headers-End: 1nreEO-00921R-Ds
Subject: Re: [f2fs-dev] [PATCH v3 4/5] f2fs: use the updated
 test_dummy_encryption helper functions
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
Cc: Lukas Czerner <lczerner@redhat.com>, Jeff Layton <jlayton@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/5/14 7:16, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Switch f2fs over to the functions that are replacing
> fscrypt_set_test_dummy_encryption().  Since f2fs hasn't been converted
> to the new mount API yet, this doesn't really provide a benefit for
> f2fs.  But it allows fscrypt_set_test_dummy_encryption() to be removed.
> 
> Also take the opportunity to eliminate an #ifdef.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
