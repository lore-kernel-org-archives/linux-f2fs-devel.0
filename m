Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A4BC77B7E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 May 2023 10:25:46 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q3a4N-0004du-2E;
	Mon, 29 May 2023 10:25:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1q3a4F-0004dn-1z
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 May 2023 10:25:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nKO1AmfkJgXzA7HHgGEQg4IKtEzM+c/6Utx+qrCfOsM=; b=Mio4HLDPDN48/5TngBPFO0AmyL
 GF1sEfhmSO/4VxdACj5fGZmhZDThv9CASANrWw4gw73Km9Zpz5JvpFHD9BvqGM4m4FzqtQK8uzGaa
 a0gtvWBCIHzmyB5kSB3vT1ru6cgPsmVk87PkFCsdqf3fIE8txf4ERiAONaOzo05Iw+iM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nKO1AmfkJgXzA7HHgGEQg4IKtEzM+c/6Utx+qrCfOsM=; b=fcQL7RXK/R5a4TB/l5RfMmSh9W
 YoMNfesKGvt9UNdvmP5vbI0wNdXUKuRGzPVbsGSJAw0Ul5aAku2J0NQlt66fQvuLtAF7zY7ywCjtg
 m8MGZuE5MQOBy8aXxiGzuWZVSFlH/J+GJPN5uD626mpnVFVXIhvr84PQFPyGfkyaTj4M=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q3a4F-005eW0-08 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 May 2023 10:25:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9952962275;
 Mon, 29 May 2023 10:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0B8C43444;
 Mon, 29 May 2023 10:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685355929;
 bh=mhmseRew1rTCm9zFzSEkDkJPwSum8ODdYqdgHcRs1tQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rImqZZFWn1Z5wwnr0T9nik+nA4fB2I6kyceTt80Ut5bW1Qi+LtLkYW53sET8AA9s5
 j38Zb0ae9NV5+somZ0caRc92HiPGxWkcGvTa5jZpYgdEzo1hDdgm0jsGLggnQLbd2e
 BDXI6Shvhv8W5dRYiRX3xfXWPLS0Cs1hKIOdG9HXvXmvHVyuzt7pJL6HhBq4kJc58w
 pmyEFTuhvTlNO3gzt0BK0AjEk/xhZ9CSJQ6H6OT/QlypRdUOaSgHycuUIHVx99xLg1
 i4FU33TqQMwOBKWltsomjJZbJ6nGQNIjMPTGwCrvN1ILBU6T3Nw7DQUf/npbMmuZsl
 NOjwknuidvWrg==
Message-ID: <f542a922-affe-23ae-f023-05ec5ca20b9c@kernel.org>
Date: Mon, 29 May 2023 18:25:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Chunhai Guo <guochunhai@vivo.com>
References: <20230527170640.37930-1-guochunhai@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230527170640.37930-1-guochunhai@vivo.com>
X-Headers-End: 1q3a4F-005eW0-08
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: Detect looped node chain efficiently
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 frank.li@vivo.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/5/28 1:06, Chunhai Guo wrote:
> find_fsync_dnodes() detect the looped node chain by comparing the loop
> counter with free blocks. While it may take tens of seconds to quit when
> the free blocks are large enough. We can use Floyd's cycle detection
> algorithm to make the detection more efficient.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
