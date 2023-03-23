Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (unknown [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6C2C6FD1C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Mar 2023 14:32:40 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pfLza-0000YT-JO;
	Thu, 23 Mar 2023 14:32:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pfLzX-0000YH-Ks
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Mar 2023 14:32:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iadFUoqqKW9Z6xVM7nu3j6bDDokOlOPdaO/XWRnrmX4=; b=dnK2nGqOqahsQXKyCHlgi35G3N
 shtlLTDIitJK5M0rnvubg2CzaIbBKmY4xywr10vyd9coEJ+2n405KNs8l6/OLNEt4oVGHCoMyM4K3
 4XRMsJaDaREBhO+jYmCvrtWdzgPJMDOYQNGmJVVziq8PeKXEwlx86W51UmJF1m1SOHXI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iadFUoqqKW9Z6xVM7nu3j6bDDokOlOPdaO/XWRnrmX4=; b=JjFx0ECnKaKPod+P5HvYtqRZnY
 8ZKpaQlavMGK5+Mb5zt7irIS4ays0FJ5T/rqyeyjQhN50ydGAO4KNVr1XkARJQwj5dfsPlHwp14DB
 c2QuaqLmXaYq0fyKRWzN9BDVeSbkRweZR0+DL+/315SlmMsFVecVHHPHBXaKfWJ7TTak=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pfLzX-000I2Y-Nz for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Mar 2023 14:32:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5AADB62769
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 23 Mar 2023 14:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76DCC433EF;
 Thu, 23 Mar 2023 14:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1679581949;
 bh=HHWrNMrPlNwL81CabBt0+fkOmCZiHtHeEc00qjEhBTE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kEn9mn0wY9dmxlUr9qFUf+dpySxwscUg07B4sar7MR0Wx0CTG13oBMTAM/oPBp0Cg
 EkuTrNgG1ULF4umJ4seD677BShuGXEgqwInyYnKon/DxmfTMxx7N3s0mWkuLM0FSGI
 NcIWl3UKC2KnXWyfrZaKWzQh7LA8fARh6SZkicPGb+IIzYDO+KnSkzkwGxiEHXa6O0
 HbvnUksEqKuPJvnyYpjxgRs3OsvNlc6TxnNbvc/RWCt3RjN7TS+UpkNt5i4KE1xYT9
 1BmEggt8owjnw4Y0HrjCwEfGvV+gniqfh08Y1OvyBK3iTXHqd3v/b20bHldDzsdIGS
 6V2kXDXQGvOEA==
Message-ID: <a58bbd47-6390-91b5-b00c-0399362c95c7@kernel.org>
Date: Thu, 23 Mar 2023 22:32:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20230313201216.924234-1-jaegeuk@kernel.org>
 <20230313201216.924234-4-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230313201216.924234-4-jaegeuk@kernel.org>
X-Headers-End: 1pfLzX-000I2Y-Nz
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: remove entire rb_entry sharing
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
Cc: stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/3/14 4:12, Jaegeuk Kim wrote:
> This is a last part to remove the memory sharing for rb_tree in extent_cache.
> 
> This should also fix arm32 memory alignment issue.
> 
> [struct extent_node]               [struct rb_entry]
> [0] struct rb_node rb_node;        [0] struct rb_node rb_node;
>    union {                              union {
>      struct {                             struct {
> [16]  unsigned int fofs;           [12]    unsigned int ofs;
>        unsigned int len;                    unsigned int len;
>                                           };
>                                           unsigned long long key;
>                                         } __packed;
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 13054c548a1c ("f2fs: introduce infra macro and data structure of rb-tree extent cache")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
