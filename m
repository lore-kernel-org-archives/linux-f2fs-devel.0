From: Gao feng <gaofeng@cn.fujitsu.com>
Subject: Re: [PATCH] f2fs: introduce f2fs_kmem_cache_alloc to hide the unfailed
 kmem cache allocation
Date: Tue, 22 Oct 2013 11:49:58 +0800
Message-ID: <5265F5E6.3000604@cn.fujitsu.com>
References: <5264D6C7.9000202@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5264D6C7.9000202@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: Kim <jaegeuk.kim@samsung.com>, f2fs <linux-f2fs-devel@lists.sourceforge.net>, fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 10/21/2013 03:24 PM, Gu Zheng wrote:
> +static inline void *f2fs_kmem_cache_alloc(struct kmem_cache *cachep,
> +						gfp_t flags)
> +{
> +	void *entry = kmem_cache_alloc(cachep, flags);
> +retry:

retry after kmem_cache_alloc?

> +	if (!entry) {
> +		cond_resched();
> +		goto retry;
> +	}
> +
> +	return entry;
> +}
