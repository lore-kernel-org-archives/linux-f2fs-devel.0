From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: fix to check inline_xattr_size boundary
 correctly
Date: Mon, 4 Mar 2019 14:39:06 +0800
Message-ID: <82ef0ff8-452c-1894-6776-41c70ad7654b@huawei.com>
References: <20190214160825.4973-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214160825.4973-1-chao@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2019/2/15 0:08, Chao Yu wrote:
> ---
> v2:
> - fix lower bound check, inline xattr size should be larger than
> xattr_header's size at least.

...

> +		if (F2FS_OPTION(sbi).inline_xattr_size <
> +			sizeof(struct f2fs_xattr_header) / sizeof(__le32)

No sure we should set this low bound as above... now I guess original
non-zero check is enough.

How do you think of setting inline_xattr_size range as
(0, MAX_INLINE_XATTR_SIZE]?

Thanks,
