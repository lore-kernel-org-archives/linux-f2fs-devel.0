From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: read page index before freeing
Date: Mon, 26 Nov 2018 17:13:53 +0800
Message-ID: <3ebe6814-586e-77e8-52fa-47fb61d760f5@huawei.com>
References: <1542884326-74903-1-git-send-email-bianpan2016@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542884326-74903-1-git-send-email-bianpan2016@163.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pan Bian <bianpan2016@163.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Pan,

On 2018/11/22 18:58, Pan Bian wrote:
> The function truncate_node frees the page with f2fs_put_page. However,
> the page index is read after that. So, the patch reads the index before
> freeing the page.

I notice that you found another use-after-free bug in ext4, out of
curiosity, I'd like to ask how do you find those bugs? by tool or code review?

Thanks,
