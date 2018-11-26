From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: read page index before freeing
Date: Mon, 26 Nov 2018 19:07:08 +0800
Message-ID: <f8957864-fd65-6c45-de07-9e94459bed52@huawei.com>
References: <1542884326-74903-1-git-send-email-bianpan2016@163.com>
 <3ebe6814-586e-77e8-52fa-47fb61d760f5@huawei.com> <20181126102841.GA94853@bp>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181126102841.GA94853@bp>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: PanBian <bianpan2016@163.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/11/26 18:28, PanBian wrote:
> On Mon, Nov 26, 2018 at 05:13:53PM +0800, Chao Yu wrote:
>> Hi Pan,
>>
>> On 2018/11/22 18:58, Pan Bian wrote:
>>> The function truncate_node frees the page with f2fs_put_page. However,
>>> the page index is read after that. So, the patch reads the index before
>>> freeing the page.
>>
>> I notice that you found another use-after-free bug in ext4, out of
>> curiosity, I'd like to ask how do you find those bugs? by tool or code review?
> 
> I found such bugs by the aid of a tool I wrote recently. I designed a method 
> to automatically find paired alloc/free functions. With such functions, I
> wrote two checkers, one to check mismatched alloc/free bugs, the other to
> check use-after-free and double-free bugs.

Excellent! Do you have any plan to open its source or announce it w/ binary
to linux kernel developers, I think w/ it we can help to improve kernel's
code quality efficiently.

Thanks,

> 
> Best regards,
> Pan Bian
> 
> 
> .
> 
