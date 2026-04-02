Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585EDD6AB10
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  2 Apr 2026 21:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:Message-ID:
	In-Reply-To:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ScbF1cEJLrssyX5ie8QJsoQuO2lLV2b7XpZLawUfngQ=; b=OIC0tFo41vNuAFLqsAV88sLRjj
	s49Rua9EHO07fK5rszh+vxv+k8qtHA6FtBB/pVyb2K7sCH8uPCOBqMFOCoRK7AbjBm+r/eh4EKt67
	1zoH4HGoJIC9BRbeNMyoRISdU05nHXuCxPwoCo5Cv0YzKBz4dfdZHlwyaELt3B7IA+V4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w8Q3j-0004jw-VY;
	Thu, 02 Apr 2026 21:58:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <pjw@kernel.org>) id 1w8Q3h-0004jo-Rz
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Apr 2026 21:58:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:References:Message-ID:
 In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XuToGNZ0fDyV9ckReF7x/iBdAj/35w5vB4q5GhoKJJE=; b=chppzhsBulAylYTgW+my7gInC8
 gbMe3Z5q61Rotw/g22Ixghd/gFpPWAjufagpf3aynIQpYG7tVT7h48Z/8Q1LMsS9AjcWD6FIcoq/i
 ZuZQpcunngNEPDP0qKgmivn7rP8iKPLWmy+StKepMAKuSowWTDEO7I594HAV1H/qKE/M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:References:Message-ID:In-Reply-To:Subject:cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XuToGNZ0fDyV9ckReF7x/iBdAj/35w5vB4q5GhoKJJE=; b=MFIJVsSWue2jUPAWl7arkJmXLr
 LR0vRLXW10SNwLIDHTqqV6ovgHuT1qRevA4u8pMCv/yG64k/h2fVEfKVDGFPGERTySC7mjXZ/Cv+x
 F99CCKTBMv5YnpZkAHzevu9VVwuPI516JAyaCx4Wbg2v9HuOX3gAruYosm0BdqTHchfQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w8Q3h-00008F-7x for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Apr 2026 21:58:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B9BAC403EA;
 Thu,  2 Apr 2026 21:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D96C116C6;
 Thu,  2 Apr 2026 21:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775167106;
 bh=QvUc9vANqYsb1luDp8UYk1f8BqkeVaTMVXLV75eutnQ=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=KBJzCsq7TNcgHpU+TWPAd3W8YuuJXdgpviR9Ow38UzYp/E+eDMYCQdUq5+04/Mnru
 vF8yruBgH9Kqoxj3RdUA00tDQnEgnr1qE7AXbmqG7qka9IVu/f1eZKTg86JWT+ETrn
 TjxI1jdECoYVYFvAydaPvhTr0DLyOkSNS0rHhfEWArmmkmeciwTpFwX+5aQHpstoUl
 foXfbAlUvknuR2UINHvJ3kK1f5ozCCWUSVy6PFFL3eEN4gpoDz+keSHvFP6Ep2zvPe
 Ej2doeiB7lotVTyVy6ov80wS5IsFWdnGSH4WR6z1XJ7lBV9TObDwXGWdYhpggyK3MT
 1b1VbHt8uneOw==
Date: Thu, 2 Apr 2026 15:58:18 -0600 (MDT)
To: Yury Norov <ynorov@nvidia.com>
In-Reply-To: <20260304012717.201797-9-ynorov@nvidia.com>
Message-ID: <ee15482d-22a8-9686-ba64-d216b25d8e68@kernel.org>
References: <20260304012717.201797-1-ynorov@nvidia.com>
 <20260304012717.201797-9-ynorov@nvidia.com>
MIME-Version: 1.0
X-Headers-End: 1w8Q3h-00008F-7x
Subject: Re: [f2fs-dev] [PATCH 8/8] arch: use rest_of_page() macro where
 appropriate
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
From: Paul Walmsley via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Paul Walmsley <pjw@kernel.org>
Cc: Latchesar Ionkov <lucho@ionkov.net>, Zheng Gu <cengku@gmail.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Alexander Duyck <alexanderduyck@fb.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org,
 Jaroslav Kysela <perex@perex.cz>, linux-perf-users@vger.kernel.org,
 linux-mm@kvack.org, Eric Dumazet <edumazet@google.com>,
 Andreas Dilger <adilger.kernel@dilger.ca>, linux-nfs@vger.kernel.org,
 Dongsheng Yang <dongsheng.yang@linux.dev>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, David Airlie <airlied@gmail.com>,
 linux-riscv@lists.infradead.org, Simona Vetter <simona@ffwll.ch>,
 linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Yury Norov <yury.norov@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Alexandra Winter <wintera@linux.ibm.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-ext4@vger.kernel.org,
 x86@kernel.org, Tvrtko Ursulin <tursulin@ursulin.net>,
 linux-spi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Aswin Karuvally <aswin@linux.ibm.com>, intel-gfx@lists.freedesktop.org,
 Jakub Kicinski <kuba@kernel.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Carlos Maiolino <cem@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>,
 Thomas Gleixner <tglx@kernel.org>, dm-devel@lists.linux.dev,
 Jens Axboe <axboe@kernel.dk>, Albert Ou <aou@eecs.berkeley.edu>,
 Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Will Deacon <will@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 Arnaldo Carvalho de Melo <acme@kernel.org>, linux-crypto@vger.kernel.org,
 linux-block@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 virtualization@lists.linux.dev, Eric Van Hensbergen <ericvh@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Janosch Frank <frankja@linux.ibm.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Christian Brauner <brauner@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Theodore Ts'o <tytso@mit.edu>, v9fs@lists.linux.dev,
 Sean Christopherson <seanjc@google.com>, Linus Walleij <linusw@kernel.org>,
 linux-sound@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Palmer Dabbelt <palmer@dabbelt.com>,
 Anton Yakovlev <anton.yakovlev@opensynergy.com>,
 Anna Schumaker <anna@kernel.org>, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Namhyung Kim <namhyung@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 Trond Myklebust <trondmy@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, 3 Mar 2026, Yury Norov wrote:

> Switch arch code to using the macro. No functional changes intended.
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Acked-by: Paul Walmsley <pjw@kernel.org> # arch/riscv


- Paul


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
