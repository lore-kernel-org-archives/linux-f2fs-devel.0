Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68B0C761A6
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Apr 2023 00:25:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pkDRr-0006nJ-CR;
	Thu, 06 Apr 2023 00:25:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <xiubli@redhat.com>) id 1pkDRq-0006nD-Ei
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Apr 2023 00:25:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YnG+nCyPWB8ZL9Ap6fLZh9ezCdT+TIIsCMEMmA9isDc=; b=ANW7+KOAmhcdrR0cZJ9oWklhUl
 BS8oOtHyt3blSg8/OIpGwTVhOQOrphfIHY87xASRvjBmAu+uAYab++n1vboh5EslVuXiepG8D7GeA
 Sjm7FeAxQw4SK1hAzS5d86rYRVrl7JNHkRdiR808rhaUQ/27QbvgvRgdpByxps9FdZCU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YnG+nCyPWB8ZL9Ap6fLZh9ezCdT+TIIsCMEMmA9isDc=; b=mBMwsfrZZ3atiYKH2S0R01kopR
 Qol793JQIXu4vNxJvw30TJdT7PDMu0m2gLUXYTnVOBQ7d652+MzscyG7+eoxm1qt8/UJ8e1pmuaXt
 IJRniib7PsTGDn6JUuV4RcaYVlI6ULW30YdoBIj5yMuePn/BYfYKrbmsm4h82eyQKi1M=;
Received: from [170.10.129.124] (helo=us-smtp-delivery-124.mimecast.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pkDRn-0007ho-N1 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Apr 2023 00:25:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680740738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YnG+nCyPWB8ZL9Ap6fLZh9ezCdT+TIIsCMEMmA9isDc=;
 b=YCEeQBwnipV1nHPflGJuOg1bF3Zp+ZEOAgBzJRvz6rvLVFUy9KFRhgi7yapxv1LMz5MzLe
 aZBkjmMGyvb48QvEiT4wXzwhKOpHjHACkltp6WYBKhgYgl4VjmajSanRohhQIudm/EQMxA
 zAx204yastY3L4dHYA8qEqLwnvTR+Cw=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-ruQ0nVAINEeaxZ-AwJWlxg-1; Wed, 05 Apr 2023 20:25:35 -0400
X-MC-Unique: ruQ0nVAINEeaxZ-AwJWlxg-1
Received: by mail-pf1-f197.google.com with SMTP id
 e14-20020a056a00162e00b0062804a7a79bso17084680pfc.23
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 05 Apr 2023 17:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680740734;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YnG+nCyPWB8ZL9Ap6fLZh9ezCdT+TIIsCMEMmA9isDc=;
 b=8MKVdXMuHbrqzXFwrJs2xX0Nyv+qwUDtWmLch3h+C28xsaDcm4MCdXiCnp/1R2HOO2
 pJRSwscfVhiMDaU8HCNA9baAurJqTtifkycH81MGl2fqa1kaqLoPOwc5fCt6W+V4ncSA
 KO9BK4xOtsjkKJ/QsBQeGwe/7+cnqt7dKffRbizy24Xy+h0yqEgs95yrIyGmXcGC/Nrc
 Cb4xxXigMpZnbyicc4xjhIYn0JGDZdqjmOQca8E9a0jVt5VG8DQ4Cytl9zElK1jTpxTJ
 yMDxP8V0KM8TL/C6ylO7tF/5j1eLIlUHDWKgtJg8wX49qPgTRq2ltvMkGMvx990kySp6
 gy8w==
X-Gm-Message-State: AAQBX9fTQTPygPGDjV7S3obAMUvXO8RsGgwQXZ0fnxgYSL5cH1PevPj4
 zGzCyiBIdg0d7/0cgg+a9S+cu/YvFe/bwZpBZ/4pwR1xHnjv9cVQ7IJTKv9IvzSXKZ0isWsatNz
 gktmpsYqEjjfDz4fput1n5+1J6HQa5mvT/MFZvg==
X-Received: by 2002:a17:90b:17c7:b0:23f:7d05:8765 with SMTP id
 me7-20020a17090b17c700b0023f7d058765mr8769207pjb.10.1680740734095; 
 Wed, 05 Apr 2023 17:25:34 -0700 (PDT)
X-Google-Smtp-Source: AKy350YchunmOlWsqR1uqhyleFq+e6uT40JJEkEYVgwX9vsqmDYfOCSrK9/Althx8xc8uY/FzfvVaQ==
X-Received: by 2002:a17:90b:17c7:b0:23f:7d05:8765 with SMTP id
 me7-20020a17090b17c700b0023f7d058765mr8769184pjb.10.1680740733840; 
 Wed, 05 Apr 2023 17:25:33 -0700 (PDT)
Received: from [10.72.13.97] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 ce21-20020a17090aff1500b0023d386e4806sm1864484pjb.57.2023.04.05.17.25.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Apr 2023 17:25:33 -0700 (PDT)
Message-ID: <7c2bfeb5-3c93-1fc9-cc1e-e7350b406ea1@redhat.com>
Date: Thu, 6 Apr 2023 08:25:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
To: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
References: <20230404171411.699655-1-zlang@kernel.org>
 <20230404171411.699655-4-zlang@kernel.org>
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230404171411.699655-4-zlang@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Headers-End: 1pkDRn-0007ho-N1
Subject: Re: [f2fs-dev] [PATCH 3/5] fstests/MAINTAINERS: add supported
 mailing list
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
Cc: brauner@kernel.org, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 ebiggers@google.com, djwong@kernel.org, amir73il@gmail.com,
 linux-unionfs@vger.kernel.org, anand.jain@oracle.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 fdmanana@suse.com, ocfs2-devel@oss.oracle.com, jack@suse.com,
 linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net


On 4/5/23 01:14, Zorro Lang wrote:
> The fstests supports different kind of fs testing, better to cc
> specific fs mailing list for specific fs testing, to get better
> reviewing points. So record these mailing lists and files related
> with them in MAINTAINERS file.
>
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
>
> If someone mailing list doesn't want to be in cc list of related fstests
> patch, please reply this email, I'll remove that line.
>
> Or if I missed someone mailing list, please feel free to tell me.
>
> Thanks,
> Zorro
>
>   MAINTAINERS | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 77 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 09b1a5a3..620368cb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -107,6 +107,83 @@ Maintainers List
>   	  should send patch to fstests@ at least. Other relevant mailing list
>   	  or reviewer or co-maintainer can be in cc list.
>   
> +BTRFS
> +L:	linux-btrfs@vger.kernel.org
> +S:	Supported
> +F:	tests/btrfs/
> +F:	common/btrfs
> +
> +CEPH
> +L:	ceph-devel@vger.kernel.org
> +S:	Supported
> +F:	tests/ceph/
> +F:	common/ceph
> +

LGTM and feel free to add:

Acked-by: Xiubo Li <xiubli@redhat.com>

Thanks,

- Xiubo



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
