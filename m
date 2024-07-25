Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEFCC3DA5D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 25 Jul 2024 15:34:16 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sX0Tu-00042E-0D;
	Thu, 25 Jul 2024 15:34:14 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+eb6281b6209e17a76e98+7641+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1sX0Ts-000428-LM for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 Jul 2024 15:34:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Jf02KJptUmzqNSH7cWf1ELLoEYpwrFBHCIF0xHDo8l0=; b=FWD9g3+8jkjgto/7e0IqN5pwEP
 jCkerbgYh6JSJM9wpXmzOzZy1tN10/yn5KK7Xnz45GPZ72oYYTZx2o2kSjiRcVE787Tb/XCZ20WE1
 6dIqXBnlzwJEMuJcxbXt/KWZx6w7beNe4GHFYX9KuNmmLZEeO8IXzAh7FPH7eXDLfwzg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Jf02KJptUmzqNSH7cWf1ELLoEYpwrFBHCIF0xHDo8l0=; b=ggE21vs3mVbnR9qjT0Tc6lK8Fp
 k96BVt6NNkAF5zfhDG/8WoUJqOnzjbftJtq9NMF93WLW0WNZLOjjCbfPcmhHrtTH8UxAKocNNrbps
 phbHYyg0nSthuXHnmy0RWrvUAE4AgPdz0Ct/bo9ZiVbC9dWMTb6HdK0QWV8mUe9CtTxk=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sX0Ts-0001WG-0h for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 Jul 2024 15:34:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Jf02KJptUmzqNSH7cWf1ELLoEYpwrFBHCIF0xHDo8l0=; b=LIOpP/z0HDXBvgis90fj8E5C4a
 mKo04fF6xe5Kfd7gqhDDo/Ltpr6NVq86cDZZflinaEq8T3lDMs7VaQyEvc+UdG7DdZgLDnNTB64qF
 OzbeX9Jfb1r6PqIxfPAO4MeQrtJ6ObM7nkMmX4RV7s5Sodywr272B2RBteD0PacNJBgYNiVqurMZU
 psJmvT3z99KULg2rvesB8JAhCoLgJTSa8xGEpp+LMV2A9xYxYM/4lyJ4VFLC5IQuiFyLccQ6eu+MS
 oTzVGMoZDIhsp629Bhp3yThgyrqDwXxfqCe0wNzbqthfraFbl+zYMWSNZ1TW7fLBiWf4YGDBWFkRl
 EkrFh6Mw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1sX0Tj-00000001QbE-0QCv;
 Thu, 25 Jul 2024 15:34:03 +0000
Date: Thu, 25 Jul 2024 08:34:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <ZqJwa2-SsIf0aA_l@infradead.org>
References: <20240723083239.41533-1-youling.tang@linux.dev>
 <20240723083239.41533-2-youling.tang@linux.dev>
 <Zp-_RDk5n5431yyh@infradead.org>
 <0a63dfd1-ead3-4db3-a38c-2bc1db65f354@linux.dev>
 <ZqEhMCjdFwC3wF4u@infradead.org>
 <895360e3-97bb-4188-a91d-eaca3302bd43@linux.dev>
 <ZqJjsg3s7H5cTWlT@infradead.org>
 <61beb54b-399b-442d-bfdb-bad23cefa586@app.fastmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <61beb54b-399b-442d-bfdb-bad23cefa586@app.fastmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1sX0Ts-0001WG-0h
Subject: Re: [f2fs-dev] [PATCH 1/4] module: Add module_subinit{_noexit} and
 module_subeixt helper macros
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
Cc: Linux-Arch <linux-arch@vger.kernel.org>,
 Youling Tang <tangyouling@kylinos.cn>, linux-f2fs-devel@lists.sourceforge.net,
 Theodore Ts'o <tytso@mit.edu>, Josef Bacik <josef@toxicpanda.com>,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Chris Mason <clm@fb.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Andreas Dilger <adilger.kernel@dilger.ca>, linux-btrfs@vger.kernel.org,
 Youling Tang <youling.tang@linux.dev>, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
 linux-modules@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Jul 25, 2024 at 05:30:58PM +0200, Arnd Bergmann wrote:
> Now I think we could just make the module_init() macro
> do the same thing as a built-in initcall() and put
> an entry in a special section, to let you have multiple
> entry points in a loadable module.
> 
> There are still at least two problems though:
> 
> - while link order is defined between files in a module,
>   I don't think there is any guarantee for the order between
>   two initcalls of the same level within a single file.

I think the sanest answer is to only allow one per file.  If you
are in the same file anyway calling one function from the other
is not a big burden.  It really is when they are spread over files
when it is annoying, and the three examples show that pretty
clearly.

> - For built-in code we don't have to worry about matching
>   the order of the exit calls since they don't exist there.
>   As I understand, the interesting part of this patch
>   series is about making sure the order matches between
>   init and exit, so there still needs to be a way to
>   express a pair of such calls.

That's why you want a single macro to define the init and exit
callbacks, so that the order can be matched up and so that
error unwinding can use the relative position easily.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
