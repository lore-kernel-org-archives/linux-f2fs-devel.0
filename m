From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH -next] f2fs: fix error return code in init_f2fs_fs()
Date: Fri, 23 Aug 2013 16:44:25 +0900
Message-ID: <CAKYAXd_f_Fo9a5mSTcG5=89u9wbgm3umGHGLGPcnwc7uiYVduQ@mail.gmail.com>
References: <CAPgLHd-bUFP3Rr+yBkSgP7mm12dx4oHAvuZgswf1eTkhkdBdaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPgLHd-bUFP3Rr+yBkSgP7mm12dx4oHAvuZgswf1eTkhkdBdaA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: jaegeuk.kim@samsung.com, namjae.jeon@samsung.com, yongjun_wei@trendmicro.com.cn, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

2013/8/23, Wei Yongjun <weiyj.lk@gmail.com>:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Fix to return -ENOMEM in the kset create and add error handling
> case instead of 0, as done elsewhere in this function.
>
> Introduced by commit b59d0bae6ca30c496f298881616258f9cde0d9c6.
> (f2fs: add sysfs support for controlling the gc_thread)
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Acked-by: Namjae Jeon <namjae.jeon@samsung.com>
