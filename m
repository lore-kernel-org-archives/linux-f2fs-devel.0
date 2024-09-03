Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8EACD3420
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Sep 2024 10:04:59 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1slQPA-0004Hp-Nr;
	Tue, 03 Sep 2024 10:04:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <huangjianan@xiaomi.com>) id 1slQP9-0004HY-0o
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Sep 2024 10:04:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-ID:
 Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender
 :Reply-To:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To
 :Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YCJtvlKwGlnH0v4fIcqZym0S/odYiTTNF/thyVRPRdE=; b=dltEKf8EJvvvQbQCWPEKe7Mez4
 icd2LPylWoFgb38Z2R3G0N9L9OUXamTdGVuxgGVWPL69+V/LSBXpH499CidxWow5htXCXaL3k9YuX
 1v6sgUdh4rg3mJ00RQcarICsXtcWHw4zJENFjod0T3iaDMZJeLRG6qJGv/E8md0L2t50=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:
 In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YCJtvlKwGlnH0v4fIcqZym0S/odYiTTNF/thyVRPRdE=; b=CfbLIdCQwAzX8giXCz7eEPuDQj
 N5z+lu6ITmqvv7GxLADpcik+mkdRG1HLFZA62y79SErs8PH3nN/XEEMdrgQIXCtFexj9I3V56MXmy
 dPiEXNmLhI8eveNMd1+nf6zRYfIoDSNIj0dZ+J9tHPPluFZGYNhHdlIsyZFLhJVIDgjc=;
Received: from outboundhk.mxmail.xiaomi.com ([118.143.206.90])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtp (Exim 4.95)
 id 1slQP8-0007Mx-ON for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Sep 2024 10:04:55 +0000
X-CSE-ConnectionGUID: 6+T9Hnn8RuWjBFzMOk/HVw==
X-CSE-MsgGUID: +E2TGmDJTgiGlym54yZ89A==
X-IronPort-AV: E=Sophos;i="6.10,198,1719849600"; d="scan'208";a="95305435"
To: Wu Bo <bo.wu@vivo.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Thread-Topic: [External Mail][f2fs-dev] [PATCH 05/13] f2fs: set inline tail
 flag when create inode
Thread-Index: AQHa/d9TEJ0BFkkmf0yNrLcOSrFLD7JFSyMA
Date: Tue, 3 Sep 2024 09:49:00 +0000
Message-ID: <83bfb7d2-655e-4f3d-9bda-3f275637a3f0@xiaomi.com>
References: <cover.1725334811.git.bo.wu@vivo.com>
 <d5f1a318931b213f7a27de8441ba985354eecabb.1725334811.git.bo.wu@vivo.com>
In-Reply-To: <d5f1a318931b213f7a27de8441ba985354eecabb.1725334811.git.bo.wu@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.237.88.13]
Content-ID: <604B70C4BBC297469DA7016D8A220A7C@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1slQP8-0007Mx-ON
Subject: Re: [f2fs-dev] [External Mail] [PATCH 05/13] f2fs: set inline tail
 flag when create inode
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
From: Huang Jianan via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Huang Jianan <huangjianan@xiaomi.com>
Cc: Wu Bo <wubo.oduw@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/9/3 16:54, Wu Bo via Linux-f2fs-devel wrote:
Hi Bo,
> 
> Set inline tail flag to enable this feature when new inode is created.
> Inherit the conditions from inline data.
> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
>   fs/f2fs/namei.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 38b4750475db..13c295ea19de 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -315,6 +315,9 @@ static struct inode *f2fs_new_inode(struct mnt_idmap *idmap,
>          /* Should enable inline_data after compression set */
>          if (test_opt(sbi, INLINE_DATA) && f2fs_may_inline_data(inode))
>                  set_inode_flag(inode, FI_INLINE_DATA);
> +       /* Inherit the conditions from inline data */
> +       if (test_opt(sbi, INLINE_TAIL) && f2fs_has_inline_data(inode))
> +               set_inode_flag(inode, FI_INLINE_TAIL);

Should f2fs_post_read_required() be checked here, like inline data?

Thanks,
Jianan

> 
>          if (name && !test_opt(sbi, DISABLE_EXT_IDENTIFY))
>                  set_file_temperature(sbi, inode, name);
> --
> 2.35.3
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
