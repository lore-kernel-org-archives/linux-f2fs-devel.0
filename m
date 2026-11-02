Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F99606A324
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 01:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Dg7zfuxz;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Xj6zF9xq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MOwGdDYi;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=he/ubJEF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=MPOis2b2cScqs0a2/cL63Tw4vlVUT/e3l+bHHCp7vZc=; b=Dg7zfuxzUd9no+
	LohwnBRtd+i1182FJtdYjLu8rXYmlifGKDzAYIMMWKWSCakRu8KAEkX2YtXSADXFhWrKwd7jmv+D/
	W27A3fLSEv80o5tTVlBxJA9T9GLVNRgjqZ9V2FbCNCUakBM5780pc3m2yW4L8wS8JwUet7XLQ09si
	H3M=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNgwZ-000000005bn-0Shn;
	Mon, 02 Nov 2026 01:34:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xNgwX-000000005bh-0Hpa
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 01:34:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DMbdpKsPHWH/BwqYOKc1EJMdIZ5fFnDiu2ukpAHKdUs=; b=Xj6zF9xqgV0c7lalF2Fc9QA9qm
 Kp0oexV9KDYvz9ZntuI6QxvkOAFevOs6BwZ4uz4dN1hJSgFLBTlojyQ59jy0jKz/q+gTSfLUOEXK3
 ZxvnPgrdATzsxIK62r716jU9iLMkPZMI2q6cpY6EKs92RPvqPuTd1FGnllYTlx/5Duko=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DMbdpKsPHWH/BwqYOKc1EJMdIZ5fFnDiu2ukpAHKdUs=; b=MOwGdDYijdq/tWj7L1b+sBcpT5
 xI3ash6EXZ+/f64cbtStRX5wHVeEkgSSBxvBv/Tll0uJwMxxOPcO7nxKLCbBSGiDcPtdnW1QpK3VH
 nPqBhAMWDyM9Zh1m+pSxgn+91nd4atG1HkwZg1Vre2cV5oBk6x2m0UjivRpBomF5a7Oo=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNgwV-000000007sU-1Gy0
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 01:34:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D9FE843F2C;
 Mon,  2 Nov 2026 01:34:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819141F000C1;
 Mon,  2 Nov 2026 01:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793583269;
 bh=DMbdpKsPHWH/BwqYOKc1EJMdIZ5fFnDiu2ukpAHKdUs=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=he/ubJEFkpHMEvld/1emBTae55d++wHB68zn3kFvlZ4A/xoTpXDXcIk8shOjkb9LN
 vAChI33IgvBoJHP3iJf6Zw4tlumzCLR1/E7MAMrQ2WrMRyAiv8x3EpyA3W8J843yqu
 fzQZDEWkWZNFexPvS3LwJdyBwaquVwniIlq84qgA125woGwUM10nUbXEjUkScbfa3R
 vpPqU2CRdfTK0SJUUctrDNSiAzMf5WU8AVm3CqfrS4PvAyulN8CfMpLkjk/ze6lxMn
 6Yxhjljabyo1P+K4toOm6/TWC6db/U69dOdru5U5iVuMTLRO1r5cbFfoLOGyJJGyVi
 J2F2ZfbtK5YcQ==
Message-ID: <513d4f4f-dd02-46b3-87c5-f95e9ff47a41@kernel.org>
Date: Mon, 2 Nov 2026 09:34:25 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, jaegeuk@kernel.org
References: <20261030072423.197883-1-zhanxusheng1024@gmail.com>
Content-Language: en-US
In-Reply-To: <20261030072423.197883-1-zhanxusheng1024@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNgwV-000000007sU-1Gy0
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix use-after-free of quota file
 names on failed remount
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: sandeen@redhat.com, zhanxusheng@xiaomi.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 lihongbo22@huawei.com, syzbot+e818dd42ada3b583bed1@syzkaller.appspotmail.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 15:24, Zhan Xusheng wrote:
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> 
> f2fs_show_options() prints the journalled quota file names without any
> lock that excludes remount, and a failed remount frees the current names
> before restoring the old ones.  Reading /proc/mounts at that moment is a
> use-after-free.
> 
> Read the names under rcu_read_lock() and free them only after a grace
> period.
> 
> Fixes: 4b2414d04e99 ("f2fs: support journalled quota")
> Reported-by: syzbot+e818dd42ada3b583bed1@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e818dd42ada3b583bed1
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
